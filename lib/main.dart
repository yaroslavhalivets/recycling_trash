import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:retrash_app/di/modules/api_module.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/pages/splash_screen/splash_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';

import 'di/injector.dart';
import 'presentation/bloc/base_bloc.dart';

final logger = Logger(printer: SimplePrinter());
final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Injector.instance.inject([
    ApiModule()
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: ApplicationBloc(),
        child: MaterialApp(
          builder: (_context, navigator) {
            return Theme(
              data: _appTheme(_context),
              child: navigator!,
            );
          },
          theme: _appTheme(context),
          home: const SplashScreen(),
        ));
  }

  _appTheme(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ThemeData(
        appBarTheme: AppBarTheme(
            brightness: Brightness.light, color: Colors.transparent),
        dividerTheme: _dividerTheme(),
        fontFamily: 'Como',
        scaffoldBackgroundColor: AppColors.background,
        accentColor: AppColors.mantis,
        primaryColor: AppColors.mantis,
        textTheme: _textTheme(),
        buttonTheme: ButtonThemeData(
          height: 48.0,
          buttonColor: AppColors.mantis,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          textTheme: ButtonTextTheme.primary,
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8.0)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.07)),
                borderRadius: BorderRadius.circular(8.0))));
  }

  TextTheme _textTheme() {
    return TextTheme(
      headline1: TextStyle(
          color: Colors.white,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Como'),
      subtitle2: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.w500),
      subtitle1: TextStyle(
          fontSize: 20.0,
          color: AppColors.onPrimary,
          fontWeight: FontWeight.bold,
          fontFamily: 'Manjari'),
      bodyText1: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w500),
      button: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
      bodyText2: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 16.0,
          fontWeight: FontWeight.w400),
      overline:
          TextStyle(fontSize: 48.0, height: 1.2, color: AppColors.lightKhaki),
      headline4: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 15.0,
          fontWeight: FontWeight.w500),
      headline3: TextStyle(
          color: AppColors.onPrimary,
          fontSize: 20.0,
          fontWeight: FontWeight.bold),
    );
  }

  DividerThemeData _dividerTheme() {
    return DividerThemeData(thickness: 1.0);
  }
}

class ApplicationBloc extends BaseBloc {}
