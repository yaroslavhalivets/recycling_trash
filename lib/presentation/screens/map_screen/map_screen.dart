import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:retrash_app/data/api/location_api.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_statuses.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/info_widget/info_widget.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/map_screen/map_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class MapScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends BaseState<MapScreen, MapBloc> {
  late GoogleMapController _controller;

  Set<Marker> _markers = Set<Marker>();

  StreamSubscription? _mapIdleSubscription;
  InfoWidgetRoute? _infoWidgetRoute;

  @override
  void initState() {
    super.initState();
    bloc.trashCans.listen((data) {
      initMarkers(data);
    });
  }

  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.map, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => FutureBuilder<LocationApi?>(
      future: bloc.getCurrentLocation(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(snapshot.data!.latitude!, snapshot.data!.longitude!),
            zoom: 14.4746,
          ),
          myLocationEnabled: true,
          markers: _markers,
          onMapCreated: (controller) {
            _controller = controller;
          },
          onCameraMove: (position) {
            _mapIdleSubscription?.cancel();
            _mapIdleSubscription = Future.delayed(Duration(milliseconds: 150))
                .asStream()
                .listen((_) {
              if (_infoWidgetRoute != null) {
                if (mounted) {
                  Navigator.of(context).push(_infoWidgetRoute!).then<void>(
                    (newValue) {
                      _infoWidgetRoute = null;
                    },
                  );
                }
              }
            });
          },
        );
      });

  @override
  MapBloc provideBloc() => MapBloc();

  void initMarkers(List<TrashCanApi> trashCans) {
    List<Marker> tempMarkers = <Marker>[];
    for (TrashCanApi trashCan in trashCans) {
      tempMarkers.add(
        Marker(
          markerId: MarkerId('${trashCan.id}'),
          position:
              LatLng(trashCan.geoPoint.latitude, trashCan.geoPoint.longitude),
          onTap: () => _onTap(trashCan),
        ),
      );
    }
    if (mounted) {
      setState(() {
        _markers = tempMarkers.toSet();
      });
    }
  }

  _onTap(TrashCanApi point) async {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox;
    Rect _itemRect = renderBox!.localToGlobal(Offset.zero) & renderBox.size;

    bool isFavorite = await bloc.isActiveFavorite(point);

    _infoWidgetRoute = InfoWidgetRoute(
      buildContext: context,
      textStyle: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      mapsWidgetSize: _itemRect,
      onFullTap: () {
        bloc.changeBinStatus(point, TrashCanStatuses.full);
        Navigator.pop(context);
      },
      onBreakTap: () {
        bloc.changeBinStatus(point, TrashCanStatuses.broken);
        Navigator.pop(context);
      },
      onFavoriteActive: () {
        bloc.setFavoriteBin(point);
        Navigator.pop(context);
      },
      isFavorite: isFavorite,
      onFavoriteUnActive: () {
        bloc.setFavoriteBin(point, disActivate: true);
        Navigator.pop(context);
      },
    );

    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            point.geoPoint.latitude - 0.0001,
            point.geoPoint.longitude,
          ),
          zoom: 15,
        ),
      ),
    );

    await _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            point.geoPoint.latitude,
            point.geoPoint.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
  }
}
