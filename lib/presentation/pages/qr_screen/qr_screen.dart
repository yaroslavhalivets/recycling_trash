import 'package:flutter/cupertino.dart';
import 'package:retrash_app/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/qr_bloc/qr_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class QrScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends BaseState<QrScreen, QrBloc> {
  @override
  PreferredSizeWidget? appBar() => MainAppBar.fromText(AppStrings.qr);

  @override
  Widget body() => Column();

  @override
  QrBloc provideBloc() => QrBloc();
}
