import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:flutter/cupertino.dart' as cup;
import 'package:treex_app_next/provider/network_provider.dart';

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
      final np = Provider.of<NP>(context, listen: false);
      init() async {
        //init darkMode
        await ap.changeDarkMode(SPU.shared.getBool('darkMode') ?? false,
            init: true);
        //init autoDarkMode
        await ap.changeAutoDarkMode(
          SPU.shared.getBool('autoDarkMode') ?? true,
          init: true,
        );
        //init platform
        await ap.changePlatformInit(
            SPU.shared.getInt('platform') ?? 0, context);

        //not fast startup

        ap.changeFastStartUp(
          SPU.shared.getBool('fastStartup') ?? false,
          init: true,
        );
        if (!ap.fastStartup)
          await Future.delayed(Duration(milliseconds: 2000), () {});

        //init base url
        np.setBaseUrl(
          port: SPU.shared.getString('port')??'443',
          url: SPU.shared.getString('url')??'',
          init: false,
          secure: SPU.shared.getBool('https')??true,
        );
      }

      init().then((_) {
        if (!SPU.shared.containsKey('init')) {
          SPU.shared.setBool('init', true);
          Navigator.of(context).pushReplacementNamed('startup');
        } else {
          //TODO: dev options
          //SPU.shared.remove('init');
          Navigator.of(context).pushReplacementNamed('login');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Expanded(
          child: FlareActor(
            'assets/treex-next.flr',
            animation: 'logo',
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: isIOS(context)
              ? cup.CupertinoActivityIndicator(radius: 25)
              : CircularProgressIndicator(),
        ),
      ],
    ));
  }
}
