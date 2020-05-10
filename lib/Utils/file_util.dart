import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:intl/intl.dart';

class FileUtil {
  static IconData getFileIcon({@required bool isDir, @required String name}) {
    return isDir
        ? MaterialCommunityIcons.folder
        : _getCustomFileIcon(suffix: getSuffix(name));
  }

  static IconData _getCustomFileIcon({String suffix}) {
    switch (suffix) {
      case 'txt':
        return MaterialCommunityIcons.text;

      default:
        return MaterialCommunityIcons.file;
    }
  }

  static String getSuffix(String name) {
    int index = name.lastIndexOf('.');
    if (index == -1)
      return name;
    else
      return name.substring(name.lastIndexOf('.') + 1);
  }

  static String getFileDate(DateTime date,
      {@required BuildContext context, bool detail = false}) {
    DateTime nowDate = DateTime.now();
    int nowMill = nowDate.millisecondsSinceEpoch;
    int dateMill = date.millisecondsSinceEpoch;
    int mid = nowMill - dateMill;

    //detail
    if (detail) {
      return DateFormat('yyyy.MM.dd-h:m:s').format(date);
    }

    if (mid < timeMillMap[TimeMill.MINUTE]) {
      //second
      return '${(mid ~/ timeMillMap[TimeMill.SECOND])} ${S.of(context).secondsAgo}';
    } else if (mid < timeMillMap[TimeMill.HOUR]) {
      //minute
      return '${mid ~/ timeMillMap[TimeMill.MINUTE]} ${S.of(context).minutesAgo}';
    } else if (mid < timeMillMap[TimeMill.DAY]) {
      int toDay = nowDate.day;
      int yesterday = date.day;
      if (toDay == yesterday) {
        //hour
        return '${(mid ~/ timeMillMap[TimeMill.HOUR])} ${S.of(context).hoursAgo}';
      } else {
        //yesterday
        return S.of(context).yesterday;
      }
    } else if (mid < timeMillMap[TimeMill.MONTH]) {
      return '${mid ~/ timeMillMap[TimeMill.DAY]} ${S.of(context).daysAgo}';
    } else {
      return DateFormat('yyyy.MM.dd-h:m:s').format(date);
    }
  }

  static Map<TimeMill, int> timeMillMap = {
    TimeMill.SECOND: 1000,
    TimeMill.MINUTE: 1000 * 60,
    TimeMill.HOUR: 1000 * 60 * 60,
    TimeMill.DAY: 1000 * 60 * 60 * 24,
    TimeMill.MONTH: 1000 * 60 * 60 * 24 * 30,
  };
}

enum TimeMill {
  SECOND,
  MINUTE,
  HOUR,
  DAY,
  MONTH,
  YEAR,
}
