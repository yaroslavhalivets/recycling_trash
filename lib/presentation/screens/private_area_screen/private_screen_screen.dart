import 'package:flutter/material.dart';
import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer.dart';
import 'package:retrash_app/presentation/screens/private_area_screen/private_area_bloc.dart';

class PrivateAreaScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _PrivateAreaScreenState();
}

class _PrivateAreaScreenState
    extends BaseState<PrivateAreaScreen, PrivateAreaBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.prices, onLeadingTap: () {
        scaffoldKey.currentState!.openDrawer();
      });

  @override
  Widget? drawer() => AppDrawer();

  @override
  Widget body() => FutureBuilder<double?>(
      future: bloc.getAwardPercentStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('У вас немає обраної цілі!'),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              _AnimatedPrize(value: snapshot.data!),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: FutureBuilder<UserApi?>(
                  future: bloc.getUser(),
                  builder: (context, snapshot) {
                    return Text(
                      '${AppStrings.currentPointsCount} ${snapshot.data?.points ?? 0}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppColors.mantis),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: FutureBuilder<PrizeApi?>(
                  future: bloc.getPrize(),
                  builder: (context, snapshot) {
                    return Text(
                      'Кількість необхідних балів: ${snapshot.data?.requiredPoints ?? 0}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: AppColors.mantis),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      });

  @override
  PrivateAreaBloc provideBloc() => PrivateAreaBloc();
}

class _AnimatedPrize extends StatefulWidget {
  final double value;

  const _AnimatedPrize({Key? key, required this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedPrizeState();
}

class _AnimatedPrizeState extends State<_AnimatedPrize> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant _AnimatedPrize oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: _value),
      duration: const Duration(seconds: 5),
      builder: (context, value, _) {
        return ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  value,
                  value
                ],
                colors: [
                  AppColors.mantis,
                  Colors.white,
                ]).createShader(rect);
          },
          child: Image.asset(AppImages.prize,
              color: AppColors.mantis,
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width),
        );
      },
    );
  }
}
