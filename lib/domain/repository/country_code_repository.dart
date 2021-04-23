import 'package:retrash_app/data/api/country_api.dart';

abstract class CountryCodeRepository {
  Future<List<CountryApi>> getCountriesCode();
}
