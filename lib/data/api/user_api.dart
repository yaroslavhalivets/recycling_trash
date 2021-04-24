import 'package:cloud_firestore/cloud_firestore.dart';

class UserApi {
  String name;
  String surname;
  String phoneNumber;
  String email;
  int? points;
  String? photoUrl;
  GeoPoint? favoriteBin;

  UserApi(this.name, this.surname, this.phoneNumber, this.email, this.points,
      this.photoUrl, this.favoriteBin);

  UserApi.init(
      this.name, this.surname, this.phoneNumber, this.email, this.photoUrl);

  factory UserApi.fromJson(Map<String, dynamic> json) {
    return UserApi(json['name'], json['surname'], json['phoneNumber'],
        json['email'], json['points'], json['photo_url'], json['favorite_bin']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'email': email,
      'points': points ?? 0,
      'photo_url': photoUrl,
      'favorite_bin': favoriteBin
    };
  }
}
