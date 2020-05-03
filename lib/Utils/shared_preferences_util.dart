import 'package:shared_preferences/shared_preferences.dart';

/// SharedPreferencesUtil
class SPU {
  static SharedPreferences _shared;
  static Future init() async {
    if (_shared == null) {
      _shared = await SharedPreferences.getInstance();
    }
  }

  static SharedPreferences get shared {
    return _shared;
  }
}
