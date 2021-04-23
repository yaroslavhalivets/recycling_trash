import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/data/api/country_api.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images/app_images.dart';

class CountryCodeTile extends StatefulWidget {
  final CountryApi country;
  final bool onSelected;

  const CountryCodeTile(
      {Key? key, required this.country, required this.onSelected})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryCodeTile> {
  late bool _onSelected;

  @override
  void initState() {
    super.initState();
    _onSelected = widget.onSelected;
  }

  @override
  void didUpdateWidget(CountryCodeTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _onSelected = widget.onSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Container(
            height: 50.0,
            padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15.0),
            child: Row(
              children: <Widget>[
                _countryFlagIcon(),
                const SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Text(
                    widget.country.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.button?.copyWith(
                        color: _onSelected
                            ? AppColors.mantis
                            : AppColors.mineShaft,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Spacer(),
                Text(
                  widget.country.dialCode,
                  style: Theme.of(context).textTheme.button?.copyWith(
                      color:
                          _onSelected ? AppColors.mantis : AppColors.mineShaft,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  width: 8.0,
                )
              ],
            ),
          ),
          onTap: _onTap,
        ),
        const Divider(),
      ],
    );
  }

  Widget _countryFlagIcon() => AnimatedSwitcher(
        duration: Duration(milliseconds: 270),
        switchInCurve: Curves.bounceInOut,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(child: child, scale: animation);
        },
        child: _onSelected
            ? Image.asset(
                AppImages.iconChecked,
                width: 25,
              )
            : Flag(
                widget.country.code.toUpperCase(),
                height: 20.0,
                width: 20.0,
              ),
      );

  void _onTap() {
    if (!_onSelected) {
      setState(() {
        _onSelected = true;
      });
    }
    if (_onSelected) {
      Navigator.of(context).pop(widget.country);
    }
  }
}
