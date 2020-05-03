import 'package:flutter/material.dart' as MD;
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/generated/l10n.dart';

Map<TargetPlatform, String> platformsStringMap(BuildContext context) => {
      TargetPlatform.android: S.of(context).material,
      TargetPlatform.iOS: S.of(context).cupertino,
      TargetPlatform.fuchsia: S.of(context).fuchsia
    };
Map<MD.TargetPlatform, IconData> platformsIconDataMap(
        MD.BuildContext context) =>
    {
      TargetPlatform.android: MaterialCommunityIcons.android,
      TargetPlatform.iOS: MaterialCommunityIcons.apple_ios,
      TargetPlatform.fuchsia: MaterialCommunityIcons.android,
    };
platformIntMap({reverse = false}) => reverse
    ? {
        0: TargetPlatform.android,
        1: TargetPlatform.iOS,
        2: TargetPlatform.fuchsia,
      }
    : {
        TargetPlatform.android: 0,
        TargetPlatform.iOS: 1,
        TargetPlatform.fuchsia: 2,
      };

class BottomNaviItem {
  BottomNaviItem(this.icon, this.title);
  IconData icon;
  String title;
}

getBottomNaviBarItems(BuildContext context, {bool ios = false}) {
  List<BottomNaviItem> bottomItems = [
    BottomNaviItem(MD.Icons.home, S.of(context).homeView),
    BottomNaviItem(MD.Icons.cloud, S.of(context).cloudView),
    BottomNaviItem(MD.Icons.account_circle, S.of(context).accountView),
  ];
  List<BottomNavigationBarItem> results = [];
  bottomItems.forEach((item) {
    results.add(
      BottomNavigationBarItem(
        icon: Icon(item.icon),
        title: Text(item.title),
      ),
    );
  });
  if (ios) {
    results.insert(
      2,
      BottomNavigationBarItem(
        icon: Icon(MD.Icons.search),
        title: Text(S.of(context).search),
      ),
    );
  }
  return results;
}
