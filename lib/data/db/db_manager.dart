import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import 'db.dart';

class DbManager implements Db {
  late final FirebaseFirestore _firestore;

  DbManager(FirebaseFirestore firestore) {
    _firestore = firestore;
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
}
