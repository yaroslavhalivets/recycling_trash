import 'package:cloud_firestore/cloud_firestore.dart';
import 'db_manager.dart';

abstract class Db {
  factory Db(FirebaseFirestore firestore) =>
      DbManager(firestore);

  Future<String?> add(String path, {required Map<String, dynamic> data});
}
