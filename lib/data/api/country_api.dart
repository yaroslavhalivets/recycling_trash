import 'package:retrash_app/data/type_alias.dart';

class CountryApi {
  final String name;
  final String dialCode;
  final String code;

  CountryApi(this.name, this.dialCode, this.code);

  factory CountryApi.fromJson(Json json) => CountryApi(
        json['name'],
        json['dial_code'],
        json['code'],
      );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dial_code': dialCode,
      'code': code,
    };
  }
}
