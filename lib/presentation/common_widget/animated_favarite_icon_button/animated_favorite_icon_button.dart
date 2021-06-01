import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_images.dart';

class AnimatedFavoriteIconButton extends StatefulWidget {
  final bool isActive;
  final VoidCallback onActivate;
  final VoidCallback onUnActivate;

  const AnimatedFavoriteIconButton(
      {Key? key,
      required this.isActive,
      required this.onActivate,
      required this.onUnActivate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedFavoriteIconButtonState();
}

class _AnimatedFavoriteIconButtonState
    extends State<AnimatedFavoriteIconButton> {
  late _Status _status;

  @override
  void initState() {
    super.initState();
    _status = widget.isActive ? _Status.active : _Status.unActive;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: _status == _Status.active
                ? Image.asset(AppImages.star, height: 25.0, width: 25.0)
                : Image.asset(AppImages.blackWhiteStar,
                    height: 25.0, width: 25.0),
          ),
        ),
      ),
    );
  }

  void onTap() {
    setState(() {
      if (_status == _Status.active) {
        _status = _Status.unActive;
      } else {
        _status = _Status.active;
      }
    });
    if (_status == _Status.active) {
      widget.onActivate();
    } else {
      widget.onUnActivate();
    }
  }
}

enum _Status { active, unActive }
