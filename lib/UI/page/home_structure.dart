import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart' as wd;
import 'package:treex_app_next/UI/global_widget/treex_notification.dart';
import 'package:treex_app_next/UI/page/account/account_view.dart';
import 'package:treex_app_next/UI/page/account/account_view_ios.dart';
import 'package:treex_app_next/UI/page/cloud/cloud_view.dart';
import 'package:treex_app_next/UI/page/cloud/cloud_view_ios.dart';
import 'package:treex_app_next/UI/page/home/home_view.dart';
import 'package:treex_app_next/UI/page/home/home_view_ios.dart';
import 'package:treex_app_next/UI/page/search/search_view_ios.dart';
import 'package:treex_app_next/UI/tools/tools_page.dart';
import 'package:treex_app_next/Utils/transfer_system/trans_download.dart';
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/app_provider.dart';
import 'package:treex_app_next/provider/network_provider.dart';
import 'package:treex_app_next/static/static_values.dart';
import 'package:treex_app_next/static/theme.dart';

class HomeStructure extends wd.StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeStructureState();
}

class _HomeStructureState extends wd.State<HomeStructure> {
  List<Widget> _pages = [HomeView(), CloudView(), AccountView()];
  int _nowIndex = 0;
  bool _reverse = false;
  double _onPointerDownDx = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final np = Provider.of<NP>(context, listen: false);

      //init download system
      TransDownload.init(np.fullUrl, np.token);

      showTN(
        context,
        title: '${S.of(context).welcomeBack}${np.profile.name}',
        icon: Icons.account_circle,
        type: StatusType.SUCCESS,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    AP ap = Provider.of<AP>(context);
    final widgetMQ = MediaQuery.of(context).size.width;
    return Theme.of(context).platform == TargetPlatform.iOS
        ? cupertino.CupertinoTabScaffold(
            tabBar: cupertino.CupertinoTabBar(
              items: getBottomNaviBarItems(context,
                  ios: Theme.of(context).platform ==
                      cupertino.TargetPlatform.iOS),
            ),
            tabBuilder: (BuildContext context, int index) {
              var widget;
              switch (index) {
                case 0:
                  widget = HomeViewIOS();
                  break;
                case 1:
                  widget = CloudViewIOS();
                  break;
                case 2:
                  widget = SearchViewIOS();
                  break;
                case 3:
                  widget = AccountViewIOS();
                  break;

                default:
                  widget = HomeViewIOS();
              }
              return cupertino.CupertinoTabView(
                builder: (context) {
                  return index == 2
                      ? SearchViewIOSParent()
                      : cupertino.CupertinoPageScaffold(child: widget);
                },
              );
            },
          )
        : Scaffold(
            floatingActionButton: ap.showFAB
                ? FloatingActionButton(
                    heroTag: 'fab',
                    child: Icon(Icons.add),
                    onPressed: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (BuildContext context,
                              Animation animation,
                              Animation secondaryAnimation) {
                            return ToolsPage();
                          },
                        ),
                      );
                    },
                  )
                : null,
            body: Listener(
              onPointerDown: (event) {
                _onPointerDownDx = event.position.dx;
              },
              onPointerUp: (event) {
                if ((event.position.dx - _onPointerDownDx) > widgetMQ / 4) {
                  _nowIndex = _nowIndex != 0 ? _nowIndex - 1 : _nowIndex;
                  _reverse = true;
                } else if ((event.position.dx - _onPointerDownDx) <
                    -widgetMQ / 4) {
                  _nowIndex = _nowIndex != 2 ? _nowIndex + 1 : _nowIndex;
                  _reverse = false;
                }
                setState(() {});
              },
              child: PageTransitionSwitcher(
                duration: Duration(milliseconds: 600),
                reverse: _reverse,
                transitionBuilder: (child, animation, secondAnimation) {
                  return SharedAxisTransition(
                    child: child,
                    animation: animation,
                    secondaryAnimation: secondAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                  );
                },
                child: _pages[_nowIndex],
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                ap.changeShowFAB(index != 2);
                _reverse = index < _nowIndex;
                setState(() {
                  _nowIndex = index;
                });
              },
              currentIndex: _nowIndex,
              selectedItemColor: AppTheme(context).getPrimary(),
              items: getBottomNaviBarItems(context),
            ),
          );
  }
}
