import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'db_manager.dart';
import 'package:retrash_app/data/type_alias.dart';

abstract class Db {
  factory Db(FirebaseFirestore firestore, FirebaseAuth firebaseAuth,
          FirebaseStorage storage) =>
      DbManager(firestore, firebaseAuth, storage);

  Future<String?> add(String path, {required Map<String, dynamic> data});

  Future<void> setData(String collectionPath,
      {String? docName, required Map<String, dynamic> data});
  Future<QueryData?> get(String collectionPath);
  Future<UserCredential> signIn(String email, String password);
  Future<String?> uploadSingleFile(String path,
      {required File fileData, String? name});
  Future<UserCredential> signUp(String email, String password);
  Future<UserCredential> singInByCredential(AuthCredential credential);
  Future<User?> getCurrentUser();
  Future<Map<String, dynamic>?> getDocument(String collectionPath,
      [String? documentName]);
  Future<void> logOut();
}
