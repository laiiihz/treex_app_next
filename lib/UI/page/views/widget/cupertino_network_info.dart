import 'package:flutter/cupertino.dart';

class CupertinoNetworkInfoIOS extends StatefulWidget {
  CupertinoNetworkInfoIOS({
    Key key,
    this.prefix,
    this.suffix,
    this.icon,
  }) : super(key: key);
  final String prefix;
  final String suffix;
  final IconData icon;
  @override
  State<StatefulWidget> createState() => _CupertinoNetworkInfoIOSState();
}

class _CupertinoNetworkInfoIOSState extends State<CupertinoNetworkInfoIOS> {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      child: Row(
        children: <Widget>[
          Icon(widget.icon),
          SizedBox(width: 10),
          Text(widget.prefix),
          Spacer(),
          Text(widget.suffix),
        ],
      ),
      onPressed: () {},
    );
  }
}
