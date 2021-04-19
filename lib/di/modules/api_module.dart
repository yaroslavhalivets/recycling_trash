import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/data/db/db_manager.dart';

import '../../main.dart';
import 'module.dart';

class ApiModule implements Module {
  @override
  void dependency() {
    _initDb();
    FirebaseFirestore firestore = sl.get<FirebaseFirestore>();
    sl.registerLazySingleton<Db>(() => DbManager(firestore));
  }

  void _initDb() {
    sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  }
}