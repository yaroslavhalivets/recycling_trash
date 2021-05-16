import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/common_widget/loader_indicator/loader_indicator.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';

const Duration _kAnimationDuration = Duration(milliseconds: 270);

typedef UpdateCallback = Future<void> Function();

class MainButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Widget child;
  final UpdateCallback? onTap;
  final VoidCallback? onDone;
  final VoidCallback? onError;
  final Color textColor;
  final Color mainColor;
  final BoxBorder? boxBorder;
  final EdgeInsets? padding;

  const MainButton(
      {Key? key,
      this.height = 54.0,
      this.width,
      required this.child,
      required this.onTap,
      this.onDone,
      this.textColor = AppColors.surface,
      this.mainColor = AppColors.mantis,
      this.onError,
      this.boxBorder,
      this.padding})
      : super(key: key);

  MainButton.fromText(String text,
      {this.height = 54.0,
      this.width,
      required this.onTap,
      this.onDone,
      this.textColor = AppColors.surface,
      this.mainColor = AppColors.mantis,
      this.onError,
      this.boxBorder, this.padding})
      : child = Text(text,
            style: TextStyle(
                fontSize: 16,
                color: onTap == null ? textColor.withOpacity(0.5) : textColor));

  @override
  State<StatefulWidget> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  _ResponseState _responseState = _ResponseState.done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: _handleTap,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
              border: widget.boxBorder,
              color: _isButtonDisabled()
                  ? widget.mainColor.withOpacity(0.5)
                  : widget.mainColor,
              borderRadius: const BorderRadius.all(
                const Radius.circular(8.0),
              )),
          child: Center(
            child: AnimatedSwitcher(
              duration: _kAnimationDuration,
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: _responseState == _ResponseState.done
                  ? widget.child
                  : const LoadingIndicator(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  bool _isButtonDisabled() => widget.onTap == null;

  void _handleTap() async {
    if (_isButtonDisabled()) return;

    if (mounted && _responseState == _ResponseState.done) {
      setState(() {
        _responseState = _ResponseState.update;
      });
    }

    UpdateCallback? refreshTap = widget.onTap;

    if (refreshTap == null) return;

    await refreshTap().then((_) {
      if (widget.onDone != null) {
        widget.onDone!();
      }
    }).catchError((e) {
      if (widget.onError != null) {
        widget.onError!();
      }
    }).whenComplete(() {
      if (mounted) {
        setState(() {
          _responseState = _ResponseState.done;
        });
      }
    });
  }
}

enum _ResponseState { update, done }
