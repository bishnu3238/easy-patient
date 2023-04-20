import 'package:flutter/widgets.dart';

class FancyRouting extends PageRouteBuilder {
  final Widget widget;
  FancyRouting({required this.widget})
      : super(
            transitionDuration: const Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> setAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return ScaleTransition(
                scale: animation,
                child: child,
                alignment: Alignment.bottomCenter,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> setAnimation) {
              return widget;
            });
}

class FadeRouting extends PageRouteBuilder {
  final Widget widget;
  FadeRouting({required this.widget})
      : super(
            transitionDuration: Duration(seconds: 1),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> setAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> setAnimation) {
              return widget;
            });
}

class SlideRouting extends PageRouteBuilder {
  final Widget widget;
  SlideRouting({ required this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 600),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> setAnimation,
                Widget child) {
              var begin = Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.elasticInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> setAnimation) {
              return widget;
            });
}
