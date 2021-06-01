import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:retrash_app/presentation/resources/app_images.dart';

class _InfoWidgetBody extends StatelessWidget {
  final VoidCallback onFavoriteTap;
  final VoidCallback onFullTap;
  final VoidCallback onBreakTap;

  const _InfoWidgetBody(
      {Key? key,
      required this.onFavoriteTap,
      required this.onFullTap,
      required this.onBreakTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Button.fromIcon(
          AppImages.star,
          onTap: onFavoriteTap
        ),
        const Divider(),
        _Button.fromText('Заповнений', onTap: onFullTap),
        const Divider(),
        _Button.fromText('Не працює', onTap: onBreakTap),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const _Button({Key? key, required this.child, required this.onTap})
      : super(key: key);

  _Button.fromText(String text, {required this.onTap})
      : child = Builder(
          builder: (context) => Text(
            text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );

  _Button.fromIcon(String iconPath, {required this.onTap})
      : child = Image.asset(iconPath, height: 25.0, width: 25.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: child,
        ),
      ),
    );
  }
}

class _InfoWidgetRouteLayout<T> extends SingleChildLayoutDelegate {
  final Rect mapsWidgetSize;
  final double width;
  final double height;

  _InfoWidgetRouteLayout(
      {required this.mapsWidgetSize,
      required this.height,
      required this.width});

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(
      mapsWidgetSize.center.dx - childSize.width / 2,
      mapsWidgetSize.center.dy - childSize.height,
    );
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.expand(width: width, height: height);
  }

  @override
  bool shouldRelayout(_InfoWidgetRouteLayout oldDelegate) {
    return mapsWidgetSize != oldDelegate.mapsWidgetSize;
  }
}

class InfoWidgetRoute extends PopupRoute {
  final double width;
  final double height;
  final BuildContext buildContext;
  final TextStyle textStyle;
  final Rect mapsWidgetSize;
  final VoidCallback onFavoriteTap;
  final VoidCallback onFullTap;
  final VoidCallback onBreakTap;

  InfoWidgetRoute({
    required this.onFavoriteTap,
    required this.onFullTap,
    required this.onBreakTap,
    required this.buildContext,
    required this.textStyle,
    required this.mapsWidgetSize,
    this.width = 150,
    this.height = 150,
    this.barrierLabel,
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);

  @override
  bool get barrierDismissible => true;

  @override
  Color? get barrierColor => null;

  @override
  final String? barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeLeft: true,
      removeRight: true,
      removeTop: true,
      child: Builder(builder: (BuildContext context) {
        return CustomSingleChildLayout(
          delegate: _InfoWidgetRouteLayout(
              mapsWidgetSize: mapsWidgetSize, width: width, height: height),
          child: InfoWidgetPopUp(
            infoWidgetRoute: this,
            onFullTap: onFullTap,
            onBreakTap: onBreakTap,
            onFavoriteTap: onFavoriteTap,
          ),
        );
      }),
    );
  }
}

class InfoWidgetPopUp extends StatefulWidget {
  const InfoWidgetPopUp({
    Key? key,
    required this.infoWidgetRoute,
    required this.onFavoriteTap,
    required this.onFullTap,
    required this.onBreakTap,
  }) : super(key: key);

  final InfoWidgetRoute infoWidgetRoute;
  final VoidCallback onFavoriteTap;
  final VoidCallback onFullTap;
  final VoidCallback onBreakTap;

  @override
  _InfoWidgetPopUpState createState() => _InfoWidgetPopUpState();
}

class _InfoWidgetPopUpState extends State<InfoWidgetPopUp> {
  late CurvedAnimation _fadeOpacity;

  @override
  void initState() {
    super.initState();
    _fadeOpacity = CurvedAnimation(
      parent: widget.infoWidgetRoute.animation!,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeOpacity,
      child: Material(
        type: MaterialType.transparency,
        textStyle: widget.infoWidgetRoute.textStyle,
        child: ClipPath(
          clipper: _InfoWidgetClipper(),
          child: Container(
            color: Colors.white,
            child: _InfoWidgetBody(
              onFavoriteTap: widget.onFavoriteTap,
              onBreakTap: widget.onBreakTap,
              onFullTap: widget.onFullTap,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoWidgetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(0.0, size.height - 10, 10.0, size.height - 10);
    path.lineTo(size.width / 2 - 10, size.height - 10);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / 2 + 10, size.height - 10);
    path.lineTo(size.width - 10, size.height - 10);
    path.quadraticBezierTo(
        size.width, size.height - 10, size.width, size.height - 20);
    path.lineTo(size.width, 10.0);
    path.quadraticBezierTo(size.width, 0.0, size.width - 10.0, 0.0);
    path.lineTo(10, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, 10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
