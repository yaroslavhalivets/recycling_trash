class UserApi {
  String name;
  String surname;
  String phoneNumber;
  String email;
  int points;
  String? photoUrl;

  UserApi(this.name, this.surname, this.phoneNumber, this.email, this.points,
      this.photoUrl);

  factory UserApi.fromJson(Map<String, dynamic> json) {
    return UserApi(json['name'], json['surname'], json['phoneNumber'],
        json['email'], json['points'], json['photo_url']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'phoneNumber': phoneNumber,
      'email': email,
      'points': points,
      'photo_url': photoUrl
    };
  }

}
