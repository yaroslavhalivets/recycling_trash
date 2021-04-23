import 'package:retrash_app/data/api/country_api.dart';
import 'package:retrash_app/domain/repository/country_code_repository.dart';
import 'package:retrash_app/main.dart';

class CountriesCodeUseCase {
  final CountryCodeRepository _repository = sl.get<CountryCodeRepository>();

  Future<List<CountryApi>> getCountriesCode() => _repository.getCountriesCode();
}
