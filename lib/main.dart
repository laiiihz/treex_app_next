import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/auth/license/sign_up_license.dart';
import 'package:treex_app_next/UI/auth/login_view.dart';
import 'package:treex_app_next/UI/auth/sign_up_view.dart';
import 'package:treex_app_next/UI/page/cloud/cloud_subviews.dart';
import 'package:treex_app_next/UI/page/home_structure.dart';
import 'package:treex_app_next/UI/page/views/about_view.dart';
import 'package:treex_app_next/UI/page/views/dev.dart';
import 'package:treex_app_next/UI/page/views/network_view.dart';
import 'package:treex_app_next/UI/page/views/safety_view.dart';
import 'package:treex_app_next/UI/page/views/settings_view.dart';
import 'package:treex_app_next/UI/page/views/transfer/transfer_download_view.dart';
import 'package:treex_app_next/UI/startup/first_startup.dart';
import 'package:treex_app_next/UI/startup/splash.dart';
import 'package:treex_app_next/Utils/local_file_util.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:treex_app_next/provider/network_provider.dart';
import 'package:treex_app_next/static/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPU.init();
  await LFU.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AP()),
      ChangeNotifierProvider(create: (_) => NP()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final routes = {
    '/': (context) => Splash(),
    'home': (context) => HomeStructure(),
    'startup': (context) => FirstStartUpPage(),
    'login': (context) => LoginView(),
    'settings': (context) => SettingsView(),
    'network': (context) => NetworkView(),
    'safety': (context) => SafetyView(),
    'about': (context) => AboutView(),
    'cloud/recycle': (context) => RecycleView(),
    'signup': (context) => SignUpView(),
    'dev': (context) => DevView(),
    'transfer/download': (context) => TransferDownloadView(),
    'licenses': (context) => SignUpLicense(),
  };

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AP>(context);
    return MaterialApp(
      title: 'treex',
      initialRoute: '/',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ap.darkMode
          ? AppTheme(context).themeDataDark()
          : AppTheme(context).themeDataLight(),
      darkTheme: ap.autoDarkMode ? AppTheme(context).themeDataDark() : null,
      routes: routes,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
