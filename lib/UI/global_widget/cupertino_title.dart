import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' as md;

Widget buildCupertinoTitle(BuildContext context, String text) {
  return Text(
    text,
    style: TextStyle(
      color: md.Theme.of(context).brightness == Brightness.dark
          ? CupertinoColors.white.withAlpha(200)
          : CupertinoColors.black.withAlpha(200),
    ),
  );
}
