import 'dart:ui';

import 'package:flutter/material.dart';

///动态模糊效果
///
/// 基于ImplicitlyAnimatedWidget
class AnimatedBlur extends ImplicitlyAnimatedWidget {
  AnimatedBlur({
    Key key,
    @required Duration duration,
    @required this.child,
    @required this.value,
  })  : assert(child != null),
        super(
          key: key,
          duration: duration,
        );
  final Widget child;
  final double value;
  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedBlurState();
}

class _AnimatedBlurState extends AnimatedWidgetBaseState<AnimatedBlur> {
  Tween<double> _blurValue;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: _blurValue.evaluate(animation),
        sigmaY: _blurValue.evaluate(animation),
      ),
      child: widget.child,
    );
  }

  @override
  void forEachTween(visitor) {
    _blurValue = visitor(
      _blurValue,
      widget.value,
      (dynamic value) => Tween<double>(begin: value),
    );
  }
}
