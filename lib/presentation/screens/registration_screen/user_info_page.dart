import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/common_widget/image_picker_alert/image_picker_alert.dart';
import 'package:retrash_app/presentation/common_widget/main_button/main_button.dart';
import 'package:retrash_app/presentation/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/presentation/common_widget/photo_picker/photo_picker.dart';
import 'package:retrash_app/presentation/screens/registration_screen/registration_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/utils/patterns.dart';
import 'package:retrash_app/utils/phone_number_formatter.dart';

class UserInfoPage extends StatefulWidget {
  final PageController pageController;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const UserInfoPage(
      {Key? key,
      required this.pageController,
      required this.transitionDuration,
      required this.transitionCurve})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _surnameEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();

  final ValueNotifier<bool> _activeButtonNotifier = ValueNotifier<bool>(false);

  File? _profilePhoto;

  @override
  void initState() {
    super.initState();
    AuthRequest authRequest =
        BlocProvider.of<RegistrationBloc>(context).authRequest;
    _nameEditingController.text = authRequest.name;
    _surnameEditingController.text = authRequest.surname;
    _emailEditingController.text = authRequest.email;
    _phoneEditingController.text = authRequest.phoneNumber;
    _profilePhoto = authRequest.profilePhoto;
    _nameEditingController.addListener(_listenFieldState);
    _emailEditingController.addListener(_listenFieldState);
    _phoneEditingController.addListener(_listenFieldState);
    _surnameEditingController.addListener(_listenFieldState);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formState,
        child: Column(
          children: [
            PhotoPicker(
              image: _profilePhoto,
              onTap: () {
                _onProfilePhotoPickerTap();
              },
            ),
            MainTextField(
              padding: const EdgeInsets.only(top: 20.0),
              textEditingController: _nameEditingController,
              hintText: AppStrings.name,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.singleWord.hasMatch(text),
              formatter: [
                FilteringTextInputFormatter.allow(Patterns.singleWord),
              ],
            ),
            MainTextField(
              padding: const EdgeInsets.only(top: 20.0),
              textEditingController: _surnameEditingController,
              hintText: AppStrings.surname,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.singleWord.hasMatch(text),
              formatter: [
                FilteringTextInputFormatter.allow(Patterns.singleWord),
              ],
            ),
            MainTextField(
              padding: const EdgeInsets.only(top: 20.0),
              textEditingController: _emailEditingController,
              hintText: AppStrings.email,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.email.hasMatch(text),
              error: AppStrings.emailError,
            ),
            MainTextField(
              padding: const EdgeInsets.only(top: 20.0),
              textEditingController: _phoneEditingController,
              hintText: AppStrings.phoneNumber,
              inputType: TextInputType.phone,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.phoneNumber.hasMatch(text),
              error: AppStrings.phoneError,
              formatter: [
                PhoneNumberFormatter(),
                LengthLimitingTextInputFormatter(14),
              ],
            ),
            ValueListenableBuilder<bool>(
              valueListenable: _activeButtonNotifier,
              builder: (context, value, _) {
                return MainButton.fromText(AppStrings.next,
                    padding: const EdgeInsets.only(top: 20.0),
                    width: MediaQuery.of(context).size.width * 0.9,
                    onTap: value ? _onNextTap : null);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameEditingController.dispose();
    _surnameEditingController.dispose();
    _emailEditingController.dispose();
    _phoneEditingController.dispose();
    _activeButtonNotifier.dispose();
    super.dispose();
  }

  void _listenFieldState() {
    _activeButtonNotifier.value =
        _nameEditingController.text.trim().isNotEmpty &&
            _surnameEditingController.text.trim().isNotEmpty &&
            _emailEditingController.text.trim().isNotEmpty &&
            _phoneEditingController.text.trim().isNotEmpty;
  }

  void _onProfilePhotoPickerTap() async {
    FocusScope.of(context).requestFocus(FocusNode());
    var source = await showSelectImageSourceAlert(context);
    if (source != null) {
      _getImage(source);
    }
  }

  void _getImage(ImageSource source) async {
    var image = await ImagePicker()
        .getImage(source: source, maxWidth: 1000, maxHeight: 1000);
    if (image != null) {
      setState(() {
        _profilePhoto = File(image.path);
      });
    }
  }

  Future<void> _onNextTap() async {
    if (_formState.currentState!.validate()) {
      var request = BlocProvider.of<RegistrationBloc>(context).authRequest;
      request.name = _nameEditingController.text.trim();
      request.surname = _surnameEditingController.text.trim();
      request.phoneNumber = _phoneEditingController.text.trim();
      request.email = _emailEditingController.text.trim();
      request.profilePhoto = _profilePhoto;

      await widget.pageController.nextPage(
          duration: widget.transitionDuration, curve: widget.transitionCurve);
    }
  }
}
