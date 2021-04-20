class Patterns {
  static final RegExp email = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static final RegExp optionalEmail =
      RegExp(r"^(^$|[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+)");
  static final RegExp textField = RegExp(r'^[a-zA-Z]+|\s');
  static final RegExp phoneNumber = RegExp(r'^\(\d{3}\)\s\d{3}-\d{4}');
  static final RegExp cityName = RegExp(r'^\s*([a-zA-Z]+\s*){1,3}');
}
