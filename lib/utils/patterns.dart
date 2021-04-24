class Patterns {
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp singleWord = RegExp(r'^[а-яєіА-ЯЄІ]+|\s');
  static final RegExp phoneNumber =
      RegExp(r'^[(][0-9]{3}[)]-?[0-9]{3}-?[0-9]{4}');
  static final RegExp password = RegExp(r'^.{8,50}');
  static final RegExp passwordDisAllow = RegExp(r'^[а-яєіА-ЯЄІ]');
}
