import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/country_api.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/injectors/country_code_use_case.dart';
import 'package:retrash_app/domain/injectors/user_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

const String _defaultCountryCode = 'ua';

class RegistrationBloc extends BaseBloc {
  final CountriesCodeUseCase _countryCodeUseCase =
      sl.get<CountriesCodeUseCase>();
  final UserUseCase _userUseCase = sl.get<UserUseCase>();

  final searchInCountryStream = BehaviorSubject<List<CountryApi>>();
  final currentCountry = BehaviorSubject<CountryApi>();

  final AuthRequest authRequest = AuthRequest.empty();

  List<CountryApi> countriesList = <CountryApi>[];

  @override
  void init() {
    super.init();
    loadCountriesCode();
  }

  @override
  void dispose() {
    searchInCountryStream.close();
    currentCountry.close();
  }

  Future<void> loadCountriesCode() async {
    await _countryCodeUseCase.getCountriesCode().then((countries) {
      _fillInitCountriesList(countries);
      _fillSearchInCountriesStream(countries);
      _getDefaultCountryCode(countries);
    });
  }

  void _fillInitCountriesList(List<CountryApi> countries) {
    countriesList.addAll(countries);
  }

  void _fillSearchInCountriesStream(List<CountryApi> countries) {
    searchInCountryStream.add(countries);
  }

  void _getDefaultCountryCode(List<CountryApi> countries) {
    final CountryApi country = countries
        .where((country) => country.code.toLowerCase() == _defaultCountryCode)
        .first;
    currentCountry.add(country);
  }

  Future<UserCredential?> signUp(AuthRequest request) async {
    UserCredential? credential;
    try {
      await _userUseCase.signUp(request);
    } catch (e) {
      logger.e(e);
    }
    return credential;
  }


  Future<UserCredential?> logIn(String email, String password) async {
    UserCredential? credential;
    try {
      credential = await _userUseCase.logIn(email, password);
    } catch (e) {
      logger.e(e);
    }
    return credential;
  }
}
