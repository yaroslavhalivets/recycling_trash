import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/common_widget/country_code_picker/country_code_tile.dart';
import 'package:retrash_app/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/common_widget/not_found_placeholder/not_found_placeholder.dart';
import 'package:retrash_app/data/api/country_api.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

Future<CountryApi?> showCountryCodePicker(
        BuildContext context, CountryApi country) =>
    showCupertinoModalPopup<CountryApi>(
        context: context,
        builder: (BuildContext context) {
          return CountryCodePicker(
            wasSelected: country,
          );
        });

class CountryCodePicker extends StatefulWidget {
  final CountryApi wasSelected;

  const CountryCodePicker({Key? key, required this.wasSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryCodePickerState();
}

class _CountryCodePickerState extends State<CountryCodePicker> {
  final RegistrationBloc _bloc = RegistrationBloc();

  final TextEditingController _searchFieldController = TextEditingController();
  final ValueNotifier<bool> _visibilityAnimationNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _queryIsNotEmptyNotifier =
      ValueNotifier<bool>(false);
  final ValueNotifier<bool> _searchCancelNotifier = ValueNotifier<bool>(false);
  final FocusNode _searchFieldFocus = FocusNode();

  late CountryApi _selectedCountry;

  @override
  void initState() {
    super.initState();
    _bloc.loadCountriesCode();
    _searchFieldFocus.addListener(_onFocus);
    _searchFieldController
        .addListener(() => _onSearch(_searchFieldController.text));
    _selectedCountry = widget.wasSelected;
  }

  @override
  void didUpdateWidget(CountryCodePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedCountry = widget.wasSelected;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        bloc: _bloc,
        child: Material(
            child: SafeArea(
          child: _body(),
        )));
  }

  @override
  void dispose() {
    _searchFieldController.dispose();
    _searchFieldFocus.dispose();
    _queryIsNotEmptyNotifier.dispose();
    _visibilityAnimationNotifier.dispose();
    _searchCancelNotifier.dispose();
    super.dispose();
  }

  Column _body() {
    return Column(
      children: <Widget>[
        _pickerHeader(),
        Expanded(
          child: Stack(
            children: <Widget>[
              StreamBuilder<List<CountryApi>>(
                stream: _bloc.searchInCountryStream,
                initialData: _bloc.countriesList,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const NotFoundPlaceholder();
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int i) {
                        return CountryCodeTile(
                          onSelected:
                              snapshot.data![i].code == _selectedCountry.code,
                          country: snapshot.data![i],
                        );
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _visibilityAnimationNotifier,
                builder: (BuildContext context, visibilityAnimationValue, _) {
                  return Visibility(
                    visible: visibilityAnimationValue,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 270),
                      color: AppColors.mineShaft.withOpacity(0.7),
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _pickerHeader() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: Text(
                  AppStrings.selectCountryCode,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              _closePickerButton(),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Divider(),
          _searchElement(),
          const SizedBox(
            height: 10.0,
          ),
        ],
      );

  Padding _closePickerButton() => Padding(
      padding: const EdgeInsetsDirectional.only(end: 10, top: 3.5),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Text(
          AppStrings.close,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: AppColors.mantis,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
        ),
      ));

  Padding _searchElement() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _searchTextField(),
            _cancelButton(),
          ],
        ),
      );

  Expanded _searchTextField() => Expanded(
        child: ValueListenableBuilder<bool>(
          valueListenable: _queryIsNotEmptyNotifier,
          builder: (BuildContext context, queryIsNotEmpty, _) {
            return MainTextField.withClearButton(
              queryIsNotEmpty,
              textEditingController: _searchFieldController,
              focusNode: _searchFieldFocus,
              textInputAction: TextInputAction.done,
              fieldStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: AppColors.mineShaft,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
              contentPadding: EdgeInsets.zero,
              fillColor: AppColors.mineShaft.withOpacity(0.1),
              suffixIcon: const Icon(
                Icons.search,
                color: AppColors.mineShaft,
                size: 24,
              ),
              hintText: AppStrings.search,
              hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: AppColors.mineShaft,
                    fontWeight: FontWeight.w100,
                  ),
            );
          },
        ),
      );

  Padding _cancelButton() => Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 15.0),
        child: ValueListenableBuilder<bool>(
          valueListenable: _searchCancelNotifier,
          builder: (context, searchCancel, _) {
            return Visibility(
              visible: searchCancel,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Center(
                  child: Text(
                    AppStrings.cancel,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: AppColors.mantis,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                onTap: _onSearchCanceled,
              ),
            );
          },
        ),
      );

  void _onSearch(String? request) {
    _onFocus();
    _onFieldNotEmpty();
    if (request == null) {
      return;
    }
    if (request.trim().isNotEmpty) {
      var searchResult = _bloc.countriesList
          .where((item) =>
              item.name.toLowerCase().startsWith(request.trim().toLowerCase()))
          .toList();
      _bloc.searchInCountryStream.add(searchResult);
    } else {
      _bloc.searchInCountryStream.add(_bloc.countriesList);
    }
  }

  void _onSearchCanceled() {
    _searchFieldController.clear();
    _searchFieldFocus.unfocus();
  }

  void _onFocus() {
    _visibilityAnimationNotifier.value = _searchFieldFocus.hasFocus &&
        _searchFieldController.text.trim().isEmpty;
    _searchCancelNotifier.value = _searchFieldFocus.hasFocus;
  }

  void _onFieldNotEmpty() {
    _queryIsNotEmptyNotifier.value =
        _searchFieldController.text.trim().isNotEmpty;
  }
}

