import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:treex_app_next/Utils/network/network_profile.dart';
import 'package:treex_app_next/Utils/network/network_util.dart';
import 'package:treex_app_next/Utils/shared_preferences_util.dart';

///network providers
///
class NP extends ChangeNotifier {
  bool _https = true;
  String _urlPrefix = '';
  String _networkPort = '443';
  String _fullUrl = '';

  /// https
  ///
  /// Default is On
  get https => _https;

  /// url  prefix
  ///
  /// example: 192.168.0.100
  get urlPrefix => _urlPrefix;

  /// network port
  ///
  /// default is 443
  get networkPort => _networkPort;

  /// network full url
  ///
  /// example :https://192.168.0.100:443
  get fullUrl => _fullUrl;

  ///change https
  netHttps(bool state) {
    _https = state;
    buildNPUrl();
    notifyListeners();
  }

  ///change port
  netPort(String port) {
    _networkPort = port;
    buildNPUrl();
    notifyListeners();
  }

  buildNPUrl() {
    _fullUrl = buildUrl(
      https: _https,
      port: _networkPort,
      baseUrl: _urlPrefix,
    );
    notifyListeners();
  }

  setBaseUrl({
    bool secure = true,
    @required String port,
    @required String url,
    bool init = false,
  }) {
    _https = secure;
    _urlPrefix = url;
    _networkPort = port == null ? '443' : port;
    _fullUrl = buildUrl(
      baseUrl: _urlPrefix,
      port: _networkPort,
      https: _https,
    );
    if (!init) {
      SPU.shared.setBool('https', _https);
      SPU.shared.setString('port', _networkPort);
      SPU.shared.setString('url', _urlPrefix);
      SPU.shared.setString('baseUrl', _fullUrl);
    }
    notifyListeners();
  }

  UserProfile _profile = UserProfile();
  UserProfile get profile => _profile;

  ///use dynamic value
  setProfile(dynamic userProfile) {
    _profile = UserProfile.fromDynamic(userProfile);
    print(userProfile);
    notifyListeners();
  }

  String _token = '';
  String get token => _token;
  setToken(String token, {bool init = false}) {
    _token = token;
    if (!init) {
      SPU.shared.setString('token', token);
    }
    notifyListeners();
  }

  SpaceEntity _spaceEntity;
  SpaceEntity get spaceEntity => _spaceEntity;
  setSpaceEntity(SpaceEntity entity) {
    _spaceEntity = entity;
    notifyListeners();
  }

  File _avatarFile;
  File get avatarFile => _avatarFile;
  setAvatarFile(File file) {
    _avatarFile = file;
    notifyListeners();
  }
}

class UserProfile {
  int backgroundColor = 0xffffff;
  String phone = '';
  String background = '';
  String name = '';
  String avatar = '';
  String email = '';
  UserProfile({
    this.backgroundColor,
    this.phone,
    this.background,
    this.name,
    this.avatar,
    this.email,
  });
  UserProfile.fromDynamic(dynamic profile) {
    this.backgroundColor = profile['backgroundColor'];
    this.phone = profile['phone'];
    this.background = profile['background'];
    this.name = profile['name'];
    this.avatar = profile['avatar'];
    this.email = profile['email'];
  }
}
