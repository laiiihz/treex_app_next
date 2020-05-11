import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/static/static_values.dart';

///App Provider
class AP extends ChangeNotifier {
  //fast startup
  bool _fastStartup = false;
  bool get fastStartup => _fastStartup;
  changeFastStartUp(bool state, {bool init = false}) {
    _fastStartup = state;
    if (!init) {
      SPU.shared.setBool('fastStartup', state);
    }
    notifyListeners();
  }

  TargetPlatform _targetPlatform = TargetPlatform.android;

  ///获取应用平台
  ///
  /// Android iOS Fuchsia
  ///
  ///
  TargetPlatform get targetPlatform => _targetPlatform;
  String platformString = '';

  ///修改应用平台
  changePlatform(TargetPlatform platform, String value) {
    _targetPlatform = platform;
    platformString = value;

    SPU.shared.setInt('platform', platformIntMap()[platform]);
    notifyListeners();
  }

  changePlatformInit(int platform, BuildContext context) {
    _targetPlatform = platformIntMap(reverse: true)[platform];
    platformString = platformsStringMap(context)[_targetPlatform];
    notifyListeners();
  }

  bool _showFAB = true;
  bool get showFAB => _showFAB;

  //修改FAB显示
  changeShowFAB(bool state) {
    _showFAB = state;
    notifyListeners();
  }

  bool _darkMode = false;
  bool _autoDarkMode = true;
  get darkMode => _darkMode;
  get autoDarkMode => _autoDarkMode;
  //修改深色模式
  changeDarkMode(bool state, {bool init = false}) {
    _darkMode = state;
    if (!init) {
      _autoDarkMode = false;
      SPU.shared.setBool('darkMode', state);
      SPU.shared.setBool('autoDarkMode', false);
    }
    notifyListeners();
  }

//修改自动深色模式
  changeAutoDarkMode(bool state, {bool init = false}) {
    _autoDarkMode = state;
    if (!init) {
      _darkMode = false;
      SPU.shared.setBool('darkMode', false);
      SPU.shared.setBool('autoDarkMode', state);
    }
    notifyListeners();
  }

  SystemUiOverlayStyle _systemUiOverlayStyle = SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  );

  bool _transparentStatusBar = false;
  bool get transparentStatusBar => _transparentStatusBar;
  //修改沉浸状态栏
  setStatusBarTransparent(bool state, {bool init = false}) {
    _transparentStatusBar = state;
    _systemUiOverlayStyle = _systemUiOverlayStyle.copyWith(
      statusBarColor: state ? Colors.transparent : Colors.black26,
    );
    if (!init) {
      SPU.shared.setBool('transparent', state);
    }
    _updateSystemOverlay();
    notifyListeners();
  }

  _updateSystemOverlay() {
    SystemChrome.setSystemUIOverlayStyle(_systemUiOverlayStyle);
  }

  //change file detail date
  bool _fileDetail = false;
  bool get fileDetail => _fileDetail;
  setFileDetail(bool state, {bool init = false}) {
    _fileDetail = state;
    if (!init) {
      SPU.shared.setBool('fileDetail', state);
    }
    notifyListeners();
  }
}
