import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_miui/flutter_miui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:treex_app_next/UI/auth/widget/login_text_field.dart';
import 'package:treex_app_next/UI/global_widget/cupertino_title.dart';
import 'package:treex_app_next/Utils/file_util.dart';
import 'package:treex_app_next/Utils/network/network_profile.dart';
import 'package:treex_app_next/Utils/ui_util.dart';
import 'package:flutter/cupertino.dart' as c;
import 'package:treex_app_next/generated/l10n.dart';
import 'package:treex_app_next/provider/network_provider.dart';

class AccountDetailView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AccountDetailViewState();
}

class _AccountDetailViewState extends State<AccountDetailView> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final np = Provider.of<NP>(context, listen: false);
      _phoneController.text = np.profile.phone;
      _emailController.text = np.profile.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final np = Provider.of<NP>(context);
    return isIOS(context)
        ? c.CupertinoPageScaffold(
            child: c.CustomScrollView(
              slivers: <Widget>[
                c.CupertinoSliverNavigationBar(
                  largeTitle: buildCupertinoTitle(context, np.profile.name),
                  previousPageTitle: S.of(context).accountView,
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: c.EdgeInsets.all(10),
                      child: c.CupertinoButton(
                        onPressed: () {
                          c.showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) {
                              return c.CupertinoActionSheet(
                                actions: <Widget>[
                                  c.CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: Text(S.of(context).updateColor),
                                  ),
                                  c.CupertinoActionSheetAction(
                                    onPressed: () {
                                      _pickImage(ImageSource.camera);
                                    },
                                    child: Icon(MaterialCommunityIcons.camera),
                                  ),
                                  c.CupertinoActionSheetAction(
                                    onPressed: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: Icon(MaterialCommunityIcons.image),
                                  ),
                                ],
                                cancelButton: c.CupertinoButton(
                                  child: c.Text(S.of(context).cancel),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisAlignment: c.MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(S.of(context).updateAvatar),
                            c.Hero(
                              tag: 'avatar',
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: np.avatarFile == null
                                    ? null
                                    : FileImage(np.avatarFile),
                                backgroundColor: Color(
                                    0xff000000 + np.profile.backgroundColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ]),
                ),
              ],
            ),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  stretch: true,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(np.profile.name),
                    background: Stack(
                      children: <Widget>[
                        Positioned(
                          right: 50,
                          top: 80,
                          child: Hero(
                            tag: 'account',
                            child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Color(
                                    0xff000000 + np.profile.backgroundColor),
                                backgroundImage: np.avatarFile == null
                                    ? null
                                    : FileImage(np.avatarFile)),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showMIUIDialog(
                                context: context,
                                dyOffset: 0.5,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      S.of(context).updateAvatar,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(S.of(context).updateColor),
                                      onTap: () {},
                                      leading: Icon(
                                          MaterialCommunityIcons.select_color),
                                      trailing: CircleAvatar(
                                        backgroundColor: Color(0xff000000 +
                                            np.profile.backgroundColor),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            _pickImage(ImageSource.camera);
                                          },
                                          icon: Icon(
                                              MaterialCommunityIcons.camera),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            _pickImage(ImageSource.gallery);
                                          },
                                          icon: Icon(
                                              MaterialCommunityIcons.image),
                                        ),
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                    ),
                                  ],
                                ),
                                label: 'account',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                      padding: c.EdgeInsets.all(10),
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          prefixIcon: c.Icon(MaterialCommunityIcons.phone),
                          labelText: S.of(context).phoneNumber,
                          border: TF.border(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: c.EdgeInsets.all(10),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          prefixIcon: c.Icon(MaterialCommunityIcons.email),
                          labelText: S.of(context).email,
                          border: TF.border(),
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          );
  }

  _pickImage(ImageSource imageSource) {
    ImagePicker.pickImage(
      source: imageSource,
      maxHeight: 600,
      maxWidth: 600,
    ).then((pic) {
      final np = Provider.of<NP>(context, listen: false);
      NetworkProfile networkProfile = NetworkProfile(context: context);
      networkProfile
          .setAvatar(file: pic, type: FileUtil.getSuffix(pic.path))
          .then((_) {
        networkProfile.profile().then((value) {
          networkProfile.getAvatar(name: np.profile.avatar).then((value) {
            np.setAvatarFile(value);
            print(np.avatarFile.lengthSync());
          });
        });
      });
    });
  }
}
