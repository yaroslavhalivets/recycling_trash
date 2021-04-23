import 'dart:io';

import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:retrash_app/common_widget/country_code_picker/country_code_picker.dart';
import 'package:retrash_app/common_widget/image_picker_alert/image_picker_alert.dart';
import 'package:retrash_app/common_widget/main_button/main_button.dart';
import 'package:retrash_app/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/common_widget/photo_picker/photo_picker.dart';
import 'package:retrash_app/data/api/country_api.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/pages/registration_screen/page_position.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';
import 'package:retrash_app/utils/page_view_animation_settings.dart';
import 'package:retrash_app/utils/patterns.dart';

class UserInfoScreen extends StatefulWidget {
  final PageController pageController;

  const UserInfoScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
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
              textEditingController: _nameEditingController,
              hintText: AppStrings.name,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.textField.hasMatch(text),
            ),
            MainTextField(
              textEditingController: _surnameEditingController,
              hintText: AppStrings.surname,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.textField.hasMatch(text),
            ),
            MainTextField(
              textEditingController: _emailEditingController,
              hintText: AppStrings.email,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.email.hasMatch(text),
              error: AppStrings.emailError,
            ),
            MainTextField(
              textEditingController: _phoneEditingController,
              hintText: AppStrings.phoneNumber,
              width: MediaQuery.of(context).size.width * 0.9,
              prefixIcon: _countryCodePicker(),
              formatter: [LengthLimitingTextInputFormatter(9)],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: _activeButtonNotifier,
                builder: (context, value, _) {
                  return MainButton.fromText(AppStrings.next,
                      width: MediaQuery.of(context).size.width * 0.9,
                      onTap: value ? _onNextTap : null);
                },
              ),
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

  Widget _countryCodePicker() {
    return StreamBuilder<CountryApi>(
      stream: BlocProvider.of<RegistrationBloc>(context).currentCountry,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: 110.0,
            child: GestureDetector(
              onTap: () {
                _getCountryCode(snapshot.data!);
              },
              child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10),
                  child: Row(
                    children: <Widget>[
                      Flag(
                        snapshot.data!.code.toUpperCase(),
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('${snapshot.data!.dialCode}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  fontSize: 18, color: AppColors.mineShaft)),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: 12,
                        width: 12,
                        child: SvgPicture.asset(AppImages.arrowDown,
                            fit: BoxFit.contain),
                      ),
                    ],
                  )),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
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

  void _getCountryCode(CountryApi country) async {
    var countryCode = await showCountryCodePicker(context, country);
    if (countryCode != null) {
      BlocProvider.of<RegistrationBloc>(context).currentCountry.add(countryCode);
    }
  }

  Future<void> _onNextTap() async {
    if (_formState.currentState!.validate()) {
      _formState.currentState!.save();

      var request = BlocProvider.of<RegistrationBloc>(context).authRequest;
      request.name = _nameEditingController.text.trim();
      request.surname = _surnameEditingController.text.trim();
      request.phoneNumber = _phoneEditingController.text.trim();
      request.email = _emailEditingController.text.trim();
      request.profilePhoto = _profilePhoto;

      await widget.pageController.animateToPage(PagePosition.secondPageIndex,
          duration: PageViewAnimationSettings.transitionDuration,
          curve: PageViewAnimationSettings.transitionCurve);
    }
  }
}
