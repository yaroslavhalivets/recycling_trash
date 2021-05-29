import 'package:retrash_app/data/type_alias.dart';

class Uid {
  String? uid;

  Uid(this.uid);

  factory Uid.fromJson(Json json) => Uid(json['uid']);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
    };
  }
}
