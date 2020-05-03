import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  IconWithText({Key key, this.child, this.text, this.onTap}) : super(key: key);
  final Widget child;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(icon: this.child, onPressed: this.onTap),
        Text(this.text),
      ],
    );
  }
}
