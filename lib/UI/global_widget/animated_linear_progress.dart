import 'package:flutter/material.dart';

class AnimatedLinearProgress extends ImplicitlyAnimatedWidget {
  AnimatedLinearProgress({
    Key key,
    Duration duration,
    this.value,
  }) : super(
          key: key,
          curve: Curves.easeInOutCubic,
          duration: duration == null ? Duration(milliseconds: 500) : duration,
        );
  final double value;
  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedLinearProgressState();
}

class _AnimatedLinearProgressState
    extends AnimatedWidgetBaseState<AnimatedLinearProgress> {
  Tween<double> _valueTween;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: LinearProgressIndicator(
        value: widget.value == null ? null : _valueTween.evaluate(animation),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _valueTween = visitor(
      _valueTween,
      widget.value,
      (dynamic value) => Tween<double>(begin: value),
    );
  }
}
