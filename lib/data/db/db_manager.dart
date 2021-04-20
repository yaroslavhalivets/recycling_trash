import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../main.dart';
import 'db.dart';

class DbManager implements Db {
  late final FirebaseFirestore _firestore;
  late final FirebaseAuth _firebaseAuth;

  DbManager(FirebaseFirestore firestore, FirebaseAuth auth) {
    _firestore = firestore;
    _firebaseAuth = auth;
  }

  @override
  Future<String?> add(String path, {required Map<String, dynamic> data}) async {
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

  Future<UserCredential?> logIn(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      logger.e(e);
    }
    return credential;
  }
}
