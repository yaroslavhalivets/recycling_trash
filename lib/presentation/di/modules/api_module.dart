import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/data/db/db_manager.dart';


import '../../../main.dart';
import 'module.dart';

class ApiModule implements Module {
  @override
  void dependency() {
    _initDb();
    FirebaseFirestore firestore = sl.get<FirebaseFirestore>();
    FirebaseAuth auth = sl.get<FirebaseAuth>();
    FirebaseStorage storage = sl.get<FirebaseStorage>();
    sl.registerLazySingleton<Db>(() => DbManager(firestore, auth, storage));
  }

  void _initDb() {
    sl.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);
    sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  }
}
