class CountryApi {
  final String name;
  final String dialCode;
  final String code;

  CountryApi(this.name, this.dialCode, this.code);

  factory CountryApi.fromJson(dynamic json) => CountryApi(
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
