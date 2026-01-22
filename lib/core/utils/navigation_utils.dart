import 'package:flutter/material.dart';

class NavigationUtils {
  static PageRouteBuilder slideTransitionRoute({
    required Widget page,
    Duration transitionDuration = const Duration(milliseconds: 300),
  }) {
    return PageRouteBuilder(
      transitionDuration: transitionDuration,
      pageBuilder: (_, animation, _) => page,
      transitionsBuilder: (_, animation, _, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).chain(
              CurveTween(curve: Curves.easeOut),
            ),
          ),
          child: child,
        );
      },
    );
  }
}