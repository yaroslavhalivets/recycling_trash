import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

typedef bool IsValid(String text);

class MainTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final List<TextInputFormatter>? formatter;
  final TextInputType? inputType;
  final IsValid? isValid;
  final String? error;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final int? maxLines;
  final bool emptyEnabled;
  final bool obscureText;
  final String? suffixText;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final EdgeInsets? contentPadding;
  final TextStyle? fieldStyle;
  final Color? fillColor;
  final TextStyle? hintStyle;

  const MainTextField(
      {Key? key,
      this.textEditingController,
      this.hintText,
      this.formatter,
      this.inputType,
      this.isValid,
      this.error,
      this.suffixIcon,
      this.onChanged,
      this.onFieldSubmitted,
      this.width,
      this.height,
      this.padding = EdgeInsets.zero,
      this.maxLines = 1,
      this.emptyEnabled = false,
      this.obscureText = false,
      this.suffixText,
      this.prefixIcon,
      this.focusNode,
      this.textInputAction,
      this.contentPadding,
      this.fieldStyle,
      this.fillColor,
      this.hintStyle})
      : super(key: key);

  @override
  _MainTextFieldState createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: TextFormField(
            focusNode: widget.focusNode,
            style: widget.fieldStyle ??
                Theme.of(context)
                    .textTheme
                    .bodyText2
                    ?.copyWith(color: AppColors.onPrimary),
            obscureText: widget.obscureText,
            keyboardType: widget.inputType,
            controller: widget.textEditingController,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
                fillColor: widget.fillColor ?? AppColors.surface,
                filled: true,
                contentPadding: widget.contentPadding,
                suffixText: widget.suffixText,
                suffixStyle: Theme.of(context).textTheme.bodyText2,
                hintText: widget.hintText,
                hintStyle:
                    widget.hintStyle ?? Theme.of(context).textTheme.bodyText2,
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                errorMaxLines: 3,
                errorStyle: Theme.of(context)
                    .textTheme
                    .button
                    ?.copyWith(color: AppColors.coral)),
            inputFormatters: widget.formatter,
            onChanged: (String text) {
              _onChanged(text);
            },
            onFieldSubmitted: (String text) {
              _onFieldSubmitted(text);
            },
            validator: (String? value) {
              if (value != null) {
                if (value.trim().isEmpty && !widget.emptyEnabled) {
                  return AppStrings.youNeedFillThisField;
                }
                if (widget.isValid != null) {
                  if (widget.isValid!(value)) {
                    return null;
                  } else {
                    return widget.error;
                  }
                }
              } else {
                return null;
              }
            }),
      ),
    );
  }

  void _onChanged(String data) {
    ValueChanged<String>? callBack = widget.onChanged;
    if (callBack != null) {
      callBack(data);
    }
  }

  void _onFieldSubmitted(String data) {
    ValueChanged<String>? callBack = widget.onFieldSubmitted;
    if (callBack != null) {
      callBack(data);
    }
  }
}
