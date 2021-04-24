import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../main.dart';
import 'db.dart';
import 'package:path/path.dart';

class DbManager implements Db {
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseStorage _firebaseStorage;

  DbManager(
      FirebaseFirestore firestore, FirebaseAuth auth, FirebaseStorage storage) {
    _firestore = firestore;
    _firebaseAuth = auth;
    _firebaseStorage = storage;
  }

  @override
  Future<String?> add(String path, {required Map<String, dynamic> data, String? docName}) async {
    DocumentReference? result;
    try {
      result = await _firestore.collection(path).add(data);
    } catch (error) {
      logger.e(error);
    }
    return result?.path;
  }

  @override
  Future<dynamic> get(String collectionPath, [String? documentName]) async {
    DocumentSnapshot? result;
    try {
      result =
          await _firestore.collection(collectionPath).doc(documentName).get();
    } catch (error) {
      logger.e(error);
    }

    return result?.data();
  }

  @override
  Future<void> setData(String collectionPath,
      {String? docName, required Map<String, dynamic> data}) async {
    try {
      await _firestore.collection(collectionPath).doc(docName).set(data);
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<UserCredential> signIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<UserCredential> signUp(String email, String password) {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<String?> uploadSingleFile(String path,
      {required File fileData, String? name}) async {
    String fileName = name ?? basename(fileData.path);

    Reference storageRef =
        _firebaseStorage.ref().child(path).child('$fileName');
    TaskSnapshot? data;

    try {
      data = await storageRef.putFile(fileData);
    } on FirebaseException catch (e) {
      logger.e(e);
    }

    return data?.ref.getDownloadURL();
  }
}
