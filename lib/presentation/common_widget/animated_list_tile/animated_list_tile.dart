import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';

class AnimatedListTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimatedListTileState();
}

class _AnimatedListTileState extends State<AnimatedListTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _flipAnimationController;
  late final Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 270));
    _flipAnimation =
        Tween<double>(end: 1.0, begin: 0.0).animate(_flipAnimationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
        widthFactor: 0.9,
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.002)
            ..rotateY(pi * _flipAnimation.value),
          child: _flipAnimation.value >= 0.5
              ? _FontSide(
                  animationController: _flipAnimationController,
                )
              : _BackSide(animationController: _flipAnimationController),
        ),
      );

  @override
  void dispose() {
    _flipAnimationController.dispose();
    super.dispose();
  }
}

class _FontSide extends StatelessWidget {
  final AnimationController animationController;

  const _FontSide({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          animationController.reverse();
        },
        child: Container(
          height: 120.0,
          color: AppColors.mantis,
        ),
      ),
    );
  }
}

class _BackSide extends StatelessWidget {
  final AnimationController animationController;

  const _BackSide({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          animationController.forward();
        },
        child: Container(
          height: 120.0,
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
