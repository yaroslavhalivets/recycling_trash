import 'package:flutter/cupertino.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/map_bloc/map_bloc.dart';

class MapScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends BaseState<MapScreen, MapBloc> {
  @override
  Widget body() => Column();

  @override
  MapBloc provideBloc() => MapBloc();
}
