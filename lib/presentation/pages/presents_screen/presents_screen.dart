import 'package:flutter/cupertino.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/presents_bloc/presents_bloc.dart';

class PresentsScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _PresentsScreenState();
}

class _PresentsScreenState extends BaseState<PresentsScreen, PresentsBloc> {
  @override
  Widget body() => Column();

  @override
  PresentsBloc provideBloc() => PresentsBloc();
}
