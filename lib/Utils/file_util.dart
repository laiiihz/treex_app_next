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
      case 'md':
      case 'MD':
        return MaterialCommunityIcons.markdown_outline;
      case 'pptx':
      case 'ppt':
        return MaterialCommunityIcons.file_powerpoint;
      case 'doc':
      case 'docx':
        return MaterialCommunityIcons.file_word;
      case 'xlsx':
      case 'xls':
        return MaterialCommunityIcons.file_excel;
      case 'zip':
      case 'rar':
      case 'zipx':
        return MaterialCommunityIcons.folder_zip;
      case 'tar':
        return MaterialCommunityIcons.zip_box;
      case 'exe':
        return MaterialCommunityIcons.windows;
      case 'bmp':
      case 'jpg':
      case 'jpeg':
      case 'heic':
        return MaterialCommunityIcons.image_outline;
      case 'mp4':
      case 'flv':
        return MaterialCommunityIcons.video_outline;
      case 'html':
        return MaterialCommunityIcons.language_html5;
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

  static Map<FileSize, int> fileSizeMap = {
    FileSize.B: 1,
    FileSize.KB: 1024,
    FileSize.MB: 1024 * 1024,
    FileSize.GB: 1024 * 1024 * 1024,
  };

  static getNetworkPathParent(String path) {
    print(path.substring(0, path.lastIndexOf('/')));
    return '.';
  }

  static String getFileSize(int size) {
    if (size < fileSizeMap[FileSize.KB])
      return '$size B';
    else if (size < fileSizeMap[FileSize.MB])
      return '${(size / fileSizeMap[FileSize.KB]).toStringAsFixed(2)} KB';
    else if (size < fileSizeMap[FileSize.GB])
      return '${(size ~/ fileSizeMap[FileSize.MB]).toStringAsFixed(2)} MB';
    else
      return '${(size / fileSizeMap[FileSize.GB]).toStringAsFixed(2)} GB';
  }

  static String getFileName(String name) {
    int lastIndex = name.lastIndexOf('/');
    if (lastIndex == -1)
      return name;
    else
      return name.substring(lastIndex + 1);
  }
}

enum TimeMill {
  SECOND,
  MINUTE,
  HOUR,
  DAY,
  MONTH,
  YEAR,
}

enum FileSize {
  B,
  KB,
  MB,
  GB,
}
