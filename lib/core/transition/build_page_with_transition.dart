// transitions.dart – ULTRA ANIMATIONS PACK 🔥
// Ahmed x ChatGPT Motion System
// ---------------------------------------------------------------

import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ---------------------------------------------------------------
// ENUM
// ---------------------------------------------------------------

enum PageTransitionType {
  fade,
  premium,
  parallax,
  spring,
  blurZoom,
  rotate3D,
  depth,
  cinematic,
  slideSoft,
  cinematicUltra,

  // NEW:
  liquidSwipe,
  pageFlip3D,
  glassMorph,
}

// ---------------------------------------------------------------
// MAIN BUILDER
// ---------------------------------------------------------------

Page buildPageWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  PageTransitionType type = PageTransitionType.premium,
  Duration duration = const Duration(milliseconds: 450),
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: duration,
    child: child,
    transitionsBuilder: (context, animation, secondary, child) {
      switch (type) {
        case PageTransitionType.fade:
          return _fade(animation, child);

        case PageTransitionType.cinematicUltra:
          return ultimateCinematicTransition(
            context,
            animation,
            secondary,
            child,
          );

        case PageTransitionType.premium:
          return _premium(animation, child);

        case PageTransitionType.parallax:
          return _parallax(animation, child);

        case PageTransitionType.spring:
          return _spring(animation, child);

        case PageTransitionType.blurZoom:
          return _blurZoom(animation, child);

        case PageTransitionType.rotate3D:
          return _rotate3D(animation, child);

        case PageTransitionType.depth:
          return _depth(animation, child);

        case PageTransitionType.cinematic:
          return _cinematic(animation, child);

        case PageTransitionType.slideSoft:
          return _slideSoft(animation, child);

        case PageTransitionType.liquidSwipe:
          return _liquidSwipe(animation, child);

        case PageTransitionType.pageFlip3D:
          return _pageFlip3D(animation, child);

        case PageTransitionType.glassMorph:
          return _glassMorph(animation, child);
      }
    },
  );
}

// ---------------------------------------------------------------
// SIMPLE FADE
// ---------------------------------------------------------------

Widget _fade(Animation<double> animation, Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutQuart),
    child: child,
  );
}

// ---------------------------------------------------------------
// PREMIUM MOTION (Apple-like Motion)
// ---------------------------------------------------------------

Widget _premium(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutExpo);

  return FadeTransition(
    opacity: Tween(begin: 0.0, end: 1.0).animate(curved),
    child: Transform.translate(
      offset: Tween(
        begin: const Offset(0, 32),
        end: Offset.zero,
      ).animate(curved).value,
      child: Transform.scale(
        scale: Tween(begin: .96, end: 1.0).animate(curved).value,
        child: child,
      ),
    ),
  );
}

// ---------------------------------------------------------------
// PARALLAX MOTION (depth feeling)
// ---------------------------------------------------------------

Widget _parallax(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

  return Transform.translate(
    offset: Tween(
      begin: const Offset(40, 0),
      end: Offset.zero,
    ).animate(curved).value,
    child: Opacity(
      opacity: Tween(begin: .0, end: 1.0).animate(curved).value,
      child: child,
    ),
  );
}

// ---------------------------------------------------------------
// SPRING POP (smooth bounce)
// ---------------------------------------------------------------

Widget _spring(Animation<double> animation, Widget child) {
  return ScaleTransition(
    scale: Tween(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(parent: animation, curve: Curves.elasticOut)),
    child: child,
  );
}

// ---------------------------------------------------------------
// BLUR ZOOM (beautiful cinematic zoom-in)
// ---------------------------------------------------------------

Widget _blurZoom(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);

  return FadeTransition(
    opacity: curved,
    child: Transform.scale(
      scale: Tween(begin: 1.06, end: 1.0).animate(curved).value,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: Tween(begin: 12.0, end: 0.0).animate(curved).value,
          sigmaY: Tween(begin: 12.0, end: 0.0).animate(curved).value,
        ),
        child: child,
      ),
    ),
  );
}

// ---------------------------------------------------------------
// 3D ROTATION (professional split card style)
// ---------------------------------------------------------------

Widget _rotate3D(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutQuart);

  return AnimatedBuilder(
    animation: curved,
    child: child,
    builder: (context, widget) {
      final angle = Tween(begin: .25, end: 0.0).animate(curved).value;

      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0014)
          ..rotateY(angle),
        child: Opacity(opacity: curved.value, child: widget),
      );
    },
  );
}

// ---------------------------------------------------------------
// DEPTH TRANSITION (Google Material 3-style)
// ---------------------------------------------------------------

Widget _depth(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCirc);

  return Transform.scale(
    scale: Tween(begin: 0.92, end: 1.0).animate(curved).value,
    child: FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(curved),
      child: child,
    ),
  );
}

// ---------------------------------------------------------------
// CINEMATIC ENTRY (film-like motion)
// ---------------------------------------------------------------

Widget _cinematic(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutExpo);

  return Opacity(
    opacity: curved.value,
    child: Transform.translate(
      offset: Tween(
        begin: const Offset(0, 70),
        end: Offset.zero,
      ).animate(curved).value,
      child: Transform.scale(
        scale: Tween(begin: 1.08, end: 1.0).animate(curved).value,
        child: child,
      ),
    ),
  );
}

// ---------------------------------------------------------------
// SLIDE SOFT (smooth & minimal)
// ---------------------------------------------------------------

Widget _slideSoft(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutQuad);

  return SlideTransition(
    position: Tween(
      begin: const Offset(0, .08),
      end: Offset.zero,
    ).animate(curved),
    child: FadeTransition(opacity: curved, child: child),
  );
}

// ---------------------------------------------------------------
// ULTIMATE CINEMATIC MOTION (3D + blur + depth)
// ---------------------------------------------------------------

Widget ultimateCinematicTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondary,
  Widget child,
) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutExpo);

  final depthCurve = CurvedAnimation(
    parent: animation,
    curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
  );

  final blurCurve = CurvedAnimation(
    parent: animation,
    curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
  );

  return AnimatedBuilder(
    animation: animation,
    builder: (context, _) {
      final depthScale = Tween(begin: 0.92, end: 1.0).animate(depthCurve).value;

      final parallaxShift = Tween(
        begin: const Offset(0, 60),
        end: Offset.zero,
      ).animate(curved).value;

      final rotation = Tween(begin: 0.07, end: 0.0).animate(curved).value;

      final blurValue = Tween(begin: 14.0, end: 0.0).animate(blurCurve).value;

      return Opacity(
        opacity: curved.value,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0012)
            ..translate(parallaxShift.dx, parallaxShift.dy)
            ..scale(depthScale)
            ..rotateX(rotation),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
            child: child,
          ),
        ),
      );
    },
  );
}

// ---------------------------------------------------------------
// LIQUID SWIPE-LIKE TRANSITION
// ---------------------------------------------------------------

class _LiquidClipper extends CustomClipper<Path> {
  final double t; // 0 -> 1

  _LiquidClipper(this.t);

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width;
    final height = size.height;

    final waveWidth = 40.0;
    final waveHeight = 60.0 * (1 - (t - 0.5).abs() * 2).clamp(0.0, 1.0);

    final x = width * t;

    path.moveTo(0, 0);
    path.lineTo(x, 0);

    final cp1 = Offset(x + waveWidth / 2, height * 0.25);
    final p1 = Offset(x, height * 0.5);
    final cp2 = Offset(x - waveWidth / 2, height * 0.75);
    final p2 = Offset(x, height);

    path.quadraticBezierTo(cp1.dx, cp1.dy - waveHeight, p1.dx, p1.dy);
    path.quadraticBezierTo(cp2.dx, cp2.dy + waveHeight, p2.dx, p2.dy);

    path.lineTo(0, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(_LiquidClipper oldClipper) => oldClipper.t != t;
}

Widget _liquidSwipe(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

  return AnimatedBuilder(
    animation: curved,
    builder: (context, _) {
      return ClipPath(clipper: _LiquidClipper(curved.value), child: child);
    },
  );
}

// ---------------------------------------------------------------
// PAGE FLIP 3D
// ---------------------------------------------------------------

Widget _pageFlip3D(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);

  return AnimatedBuilder(
    animation: curved,
    builder: (context, _) {
      final angle = (1 - curved.value) * math.pi / 2;

      return Transform(
        alignment: Alignment.centerRight,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0015)
          ..rotateY(-angle),
        child: Opacity(opacity: curved.value, child: child),
      );
    },
  );
}

// ---------------------------------------------------------------
// GLASS MORPH TRANSITION
// ---------------------------------------------------------------

Widget _glassMorph(Animation<double> animation, Widget child) {
  final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutQuad);

  return AnimatedBuilder(
    animation: curved,
    builder: (context, _) {
      final blur = Tween(begin: 20.0, end: 0.0).animate(curved).value;
      final opacity = curved.value;

      return Stack(
        fit: StackFit.expand,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: Container(color: Colors.transparent),
          ),
          Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: Tween(begin: 0.96, end: 1.0).animate(curved).value,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.15),
                    width: 1,
                  ),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.18),
                      Colors.white.withOpacity(0.04),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
