import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/loader_indicator/loader_indicator.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/common_widget/prize_tile/prize_tile.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/screens/presents_screen/presents_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class PresentsScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _PresentsScreenState();
}

class _PresentsScreenState extends BaseState<PresentsScreen, PresentsBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.prices, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => Column(
        children: [
          _currentPoints(),
          Expanded(
            child: FutureBuilder<List<PrizeApi>>(
              future: bloc.getPrizes(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LoadingIndicator();
                }
                return PageView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, int i) {
                      PrizeApi prize = snapshot.data![i];
                      return PrizeTile(
                        prize: prize,
                      );
                    });
              },
            ),
          ),
        ],
      );

  @override
  PresentsBloc provideBloc() => PresentsBloc();

  Widget _currentPoints() => Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Column(
        children: [
          Text(AppStrings.currentPointsCount,
              style: Theme.of(context).textTheme.subtitle1),
          const SizedBox(
            height: 15.0,
          ),
          FutureBuilder<UserApi?>(
            future: bloc.getUser(),
            builder: (context, snapshot) {
              return Text(
                '${snapshot.data?.points ?? 0}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: AppColors.mantis),
              );
            },
          )
        ],
      ));
}
