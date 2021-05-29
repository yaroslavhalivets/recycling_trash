import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';

class AnimatedListTile extends StatefulWidget {
  final String fontText, backTitle, backInfo, backBonuses;

  const AnimatedListTile(
      {Key? key,
      required this.fontText,
      required this.backTitle,
      required this.backInfo,
      required this.backBonuses})
      : super(key: key);

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
              ? _BackSide(
                  animationController: _flipAnimationController,
                  textTitle: widget.backTitle,
                  textInfo: widget.backInfo,
                  textBonuses: widget.backBonuses,
                )
              : _FontSide(
                  animationController: _flipAnimationController,
                  text: widget.fontText),
        ),
      );

  @override
  void dispose() {
    _flipAnimationController.dispose();
    super.dispose();
  }
}

class _BackSide extends StatelessWidget {
  final AnimationController animationController;
  final String textTitle, textInfo, textBonuses;

  const _BackSide(
      {Key? key,
      required this.animationController,
      required this.textTitle,
      required this.textInfo,
      required this.textBonuses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.002)
        ..rotateY(pi),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: () {
            animationController.reverse();
          },
          child: Container(
            padding: EdgeInsets.all(10),
            height: 120.0,
            color: Colors.greenAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  child: Text(
                    textTitle,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  alignment: Alignment.topCenter,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(textInfo),
                Text(textBonuses),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FontSide extends StatelessWidget {
  final AnimationController animationController;
  final String text;

  const _FontSide(
      {Key? key, required this.animationController, required this.text})
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
          color: AppColors.mantis,
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
