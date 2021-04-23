import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'db_manager.dart';

abstract class Db {
  factory Db(FirebaseFirestore firestore, FirebaseAuth firebaseAuth,
          FirebaseStorage storage) =>
      DbManager(firestore, firebaseAuth, storage);

  Future<String?> add(String path, {required Map<String, dynamic> data});

  Future<void> setData(String collectionPath,
      {String? docName, required Map<String, dynamic> data});
  Future<dynamic> get(String collectionPath, [String? documentName]);
  Future<UserCredential?> signIn(String email, String password);
  Future<TaskSnapshot?> uploadSingleFile(String path, {required File fileData});
  Future<UserCredential?> signUp(String email, String password);
}
