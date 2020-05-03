import 'package:flutter/cupertino.dart' as cup;
import 'package:flutter/material.dart';
import 'package:treex_app_next/UI/auth/license/sign_up_license_ios.dart';
import 'package:treex_app_next/UI/auth/license/sign_up_licenses_android.dart';

class SignUpLicense extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpLicense> {
  @override
  Widget build(BuildContext context) =>
      Theme.of(context).platform == TargetPlatform.iOS
          ? cup.CupertinoPageScaffold(
              child: SignUpLicenseIOS(),
            )
          : SignUpLicenseAndroid();
}
