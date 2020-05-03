import 'package:flutter/material.dart';

class AnimatedTranslateChild extends ImplicitlyAnimatedWidget {
  final double x;
  final double y;
  final Widget child;
  AnimatedTranslateChild({
    Key key,
    @required Duration duration,
    Curve curve = Curves.linear,
    @required this.child,
    this.x,
    this.y,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
        );
  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedTranslateChildState();
}

class _AnimatedTranslateChildState
    extends AnimatedWidgetBaseState<AnimatedTranslateChild> {
  Tween<double> _xValue;
  Tween<double> _yValue;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        _xValue.evaluate(animation),
        _yValue.evaluate(animation),
      ),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _xValue = visitor(
      _xValue,
      widget.x,
      (dynamic value) => new Tween<double>(begin: value),
    );
    _yValue = visitor(
      _yValue,
      widget.y,
      (dynamic value) => new Tween<double>(begin: value),
    );
  }
}
