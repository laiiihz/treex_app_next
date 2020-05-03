import 'package:flutter/cupertino.dart';

class CupertinoIconButton extends StatefulWidget {
  CupertinoIconButton({
    Key key,
    this.enable = true,
    this.icon,
    this.onPressed,
  }) : super(key: key);
  final bool enable;
  final IconData icon;
  final VoidCallback onPressed;
  @override
  State<StatefulWidget> createState() => _CupertinoIconButtonState();
}

class _CupertinoIconButtonState extends State<CupertinoIconButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.enable
          ? (detail) {
              _animationController.fling(velocity: 1.0);
            }
          : null,
      onTapUp: widget.enable
          ? (detail) {
              _animationController.fling(velocity: -1.0);
            }
          : null,
      onTapCancel: widget.enable
          ? () {
              _animationController.fling(velocity: -1.0);
            }
          : null,
      onTap: widget.onPressed,
      child: Semantics(
        button: true,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return Icon(
                widget.icon,
                color: CupertinoColors.activeBlue
                    .withOpacity(1 - _animation.value * 0.5),
              );
            },
          ),
        ),
      ),
    );
  }
}
