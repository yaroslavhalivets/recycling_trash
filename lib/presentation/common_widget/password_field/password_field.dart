import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retrash_app/presentation/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/utils/patterns.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      padding: const EdgeInsets.only(top: 20.0),
      textEditingController: widget.controller,
      obscureText: _obscureText,
      hintText: AppStrings.password,
      width: MediaQuery.of(context).size.width * 0.9,
      suffixIcon: GestureDetector(
        onTap: _onTap,
        child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
      ),
      isValid: (text) => Patterns.password.hasMatch(text),
      error: AppStrings.passwordLessThen8Symbols,
      formatter: [
        FilteringTextInputFormatter.deny(Patterns.passwordDisAllow),
      ],
    );
  }

  void _onTap() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
