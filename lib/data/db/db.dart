import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'db_manager.dart';

abstract class Db {
  factory Db(FirebaseFirestore firestore, FirebaseAuth firebaseAuth) =>
      DbManager(firestore, firebaseAuth);

  Future<String?> add(String path, {required Map<String, dynamic> data});

  Future<void> setData(String collectionPath,
      {String? docName, required Map<String, dynamic> data});
  Future<dynamic> get(String collectionPath, [String? documentName]);
  Future<UserCredential?> logIn(String email, String password);
}
