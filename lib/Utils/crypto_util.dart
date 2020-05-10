import 'dart:convert';

import 'package:crypto/crypto.dart';

class CryptoUtil {
  static String password({
    String raw,
    String name,
  }) {
    var utf8Raw = utf8.encode(raw);
    var utf8Name = utf8.encode(name);
    return Hmac(sha256, utf8Raw).convert(utf8Name).toString();
  }
}
