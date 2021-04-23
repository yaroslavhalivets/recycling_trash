import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:retrash_app/data/api/country_api.dart';
import 'package:retrash_app/domain/repository/country_code_repository.dart';

const String _countriesJson = 'json/countries_code.json';

class DataCountryCodeRepository implements CountryCodeRepository {
  @override
  Future<List<CountryApi>> getCountriesCode() async {
    var data = await rootBundle.loadString(_countriesJson);
    final jsonResult = json.decode(data);
    List<CountryApi> countriesList = <CountryApi>[];
    for (dynamic object in jsonResult['countries']) {
      countriesList.add(CountryApi.fromJson(object));
    }
    return countriesList;
  }
}
