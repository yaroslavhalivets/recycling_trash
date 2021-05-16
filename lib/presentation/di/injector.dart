import 'modules/module.dart';

class Injector {
  static Injector _instance = Injector._();

  static Injector get instance {
    return _instance;
  }

  Injector._();

  void inject(List<Module> modules) {
    modules.forEach((m) => m.dependency());
  }
}