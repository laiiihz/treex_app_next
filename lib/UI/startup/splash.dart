import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/Utils/network/network_profile.dart';
import 'package:treex_app_next/Utils/network/network_test.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/Utils/transfer_system/trans_download.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
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

        //init transparent status bar
        await ap.setStatusBarTransparent(
          SPU.shared.getBool('transparent') ?? false,
          init: true,
        );

        //not fast startup

        ap.changeFastStartUp(
          SPU.shared.getBool('fastStartup') ?? false,
          init: true,
        );
        if (!ap.fastStartup)
          await Future.delayed(Duration(milliseconds: 2000), () {});

        //init base url
        np.setBaseUrl(
          port: SPU.shared.getString('port') ?? '443',
          url: SPU.shared.getString('url') ?? '',
          init: false,
          secure: SPU.shared.getBool('https') ?? true,
        );
      }

      init().then((_) {
        if (!SPU.shared.containsKey('init')) {
          SPU.shared.setBool('init', true);
          Navigator.of(context).pushReplacementNamed('startup');
        } else {
          if (SPU.shared.containsKey('token')) {
            if (SPU.shared.getString('token').length == 0)
              Navigator.of(context).pushReplacementNamed('login');
            else {
              NetworkTest(
                port: np.networkPort,
                baseUrl: np.urlPrefix,
                https: np.https,
                context: context,
                onErr: () {},
              ).check().then((value) {
                if (value) {
                  np.setToken(SPU.shared.getString('token'));
                  NetworkProfile(context: context).profile().then((value) {
                    Navigator.of(context).pushReplacementNamed('home');
                  });
                } else {
                  Navigator.of(context).pushReplacementNamed('login');
                  showTN(
                    context,
                    title: S.of(context).networkFail,
                    icon: MaterialCommunityIcons.network_off,
                    type: StatusType.FAIL,
                  );
                }
              });
            }
          }
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
