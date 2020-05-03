import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/provider/app_provider.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    //first startup app
    Future.delayed(Duration.zero, () {
      final ap = Provider.of<AP>(context, listen: false);
      //init darkMode
      ap.changeDarkMode(SPU.shared.getBool('darkMode') ?? false, init: true);
      //init autoDarkMode
      ap.changeAutoDarkMode(
        SPU.shared.getBool('autoDarkMode') ?? true,
        init: true,
      );
      //init platform
      ap.changePlatformInit(SPU.shared.getInt('platform') ?? 0, context);

      //TODO:init baseUrl

      if (!SPU.shared.containsKey('init')) {
        SPU.shared.setBool('init', true);
        Navigator.of(context).pushReplacementNamed('startup');
      } else {
        //TODO: dev options
        //SPU.shared.remove('init');
        Navigator.of(context).pushReplacementNamed('login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlareActor(
        'assets/treex-next.flr',
        animation: 'logo',
      ),
    );
  }
}
