import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retrash_app/utils/error_hendler.dart';

import 'base_bloc.dart';
import 'base_screen.dart';

mixin ErrorDispatcher<Page extends BaseScreen, Bloc extends BaseBloc>
    on BaseState<Page, Bloc> {
  late StreamSubscription errorSubscription;

  @override
  void initState() {
    super.initState();
    errorSubscription = bloc.errorStream.listen((error) {
      if (error is FirebaseException) {
        showSnackBar(parseError(error));
      } else {
        showSnackBar(error);
      }
    });
  }

  @override
  void dispose() {
    errorSubscription.cancel();
    super.dispose();
  }
}
