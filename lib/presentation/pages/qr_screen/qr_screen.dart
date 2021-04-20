import 'package:flutter/cupertino.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/qr_bloc/qr_bloc.dart';

class QrScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _QrScreenState();
}

class _QrScreenState extends BaseState<QrScreen, QrBloc> {
  @override
  Widget body() => Column();

  @override
  QrBloc provideBloc() => QrBloc();
}
