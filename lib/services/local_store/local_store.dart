import 'dart:convert';
import 'package:base_project/models/backup_data.dart';
import 'package:base_project/models/country_model.dart';
import 'package:base_project/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

const String _user = 'user';
const String _searchHistory = 'searchHistory';
const String _tokenFirebase = 'tokenFirebase';
const String _tokenRegion = 'tokenRegion';
const String _kBackupKey = 'backupKey';
const String _kInappPurchase = 'inappPurchase';
const String _darkMode = 'darkMode';
const String _language = 'language';

class LocalStore {
  static final LocalStore instance = LocalStore._init();

  LocalStore._init();

  Box? myBox;

  Future init() async {
    myBox ??= await Hive.openBox('LocalStore');

    // myBox.clear();
  }

  UserModel? getUser() {
    try {
      final data = myBox?.get(_user);
      final jsons = json.decode(data as String) as Map;
      return UserModel.fromJson(jsons);
    } catch (e) {
      debugPrint('getUser Ex $e');
      return null;
    }
  }

  Future<bool?> getDarkMode() async {
    try {
      final bool data = await myBox?.get(_darkMode);
      if (data == null) {
        debugPrint('Hop bi rong~ => tao moi data!');
        myBox?.put(_darkMode, false);
        return false;
      }
      return data;
    } catch (e) {
      debugPrint('getDarkMode $e');
      return null;
    }
  }

  Future<void> changeDarkMode(bool isDarkMode) async {
    try {
      debugPrint('thay doi darkMode :$isDarkMode');
      await myBox?.put(_darkMode, isDarkMode);
    } catch (e) {
      debugPrint('changeDarkMode Ex $e');
    }
  }

  Future<Locale?> getLanguage() async {
    try {
      final data = await myBox?.get(_language);
      if (data == null) {
        debugPrint('Hop bi rong~ => tao moi data!');
        myBox?.put(_language, const Locale('en', 'US'));
      }
      if (data?.toLowerCase() == 'vi') {
        return const Locale('vi', 'VN');
      }
      return const Locale('en', 'US');
    } catch (e) {
      debugPrint('getLanguage $e');
      return null;
    }
  }

  Future<void> changerLanguage(Locale locale) async {
    try {
      await myBox?.put(_language, locale.languageCode);
      debugPrint('changerLanguage Local Store  ${locale.languageCode}');
    } catch (e) {
      debugPrint('changerLanguage debug $e');
    }
  }

  Future<void> saveUser(UserModel user) async {
    try {
      await myBox?.put(_user, user.toJson());
    } catch (e) {
      debugPrint('saveUser Ex $e');
    }
  }

  Future<void> deleteUser() async {
    await myBox?.delete(_user);
  }

  Future saveRegion(RegionModel region) async {
    await myBox?.put(_tokenRegion, region.toJson());
  }

  Future<RegionModel?> getRegion() async {
    final data = await myBox?.get(_tokenRegion);

    if (data == null) return null;
    return RegionModel.fromJson(data as Map);
  }

  String getTokenFirebase() {
    return myBox?.get(_tokenFirebase) as String;
  }

  Future<void> saveTokenFirebase(String token) async {
    await myBox?.put(_tokenFirebase, token);
  }

  Future<BackupData?> getBackupKey() async {
    final data = await myBox?.get(_kBackupKey) as String;
    return BackupData.fromString(data);
  }

  Future<void> saveBackupKey(BackupData data) async {
    await myBox?.put(_kBackupKey, data.toString());
  }

  Future<void> deleteBackupKey() async {
    await myBox?.delete(_kBackupKey);
  }

  BackupData? getInappPurchase() {
    final data = myBox?.get(_kInappPurchase) as String;
    return BackupData.fromString(data);
  }

  Future<void> saveInappPurchase(String data) async {
    await myBox?.put(_kInappPurchase, data.toString());
  }

  Future<void> deleteInappPurchase() async {
    await myBox?.delete(_kInappPurchase);
  }

  // Future<List<BackupData>> getBackupHistory() async {
  //   final data = await myBox.get(_kBackupKeyHistory) as String;

  //   if (data == null) return [];

  //   try {
  //     final jsons = json.decode(data);
  //     final list = jsons['backupCodes'] as List;
  //     return list.map((e) => BackupData.fromString(data)).toList();
  //   } catch (e) {
  //     debugPrint('getHistory $e');
  //     return [];
  //   }
  // }

  // Future<void> saveBackupHistory(BackupData data) async {
  //   if (data == null) return;
  //   final list = await getBackupHistory();
  //   list.add(data);

  //   final backup = {'backupCodes': list.map((e) => e.toString()).toList()};
  //   await myBox.put(_kBackupKeyHistory, json.encode(backup));
  // }

  Future<void> saveHistory(String keyword) async {
    if (keyword.isEmpty) return;

    final histories = await getHistory();
    histories.removeWhere((value) => value == keyword);
    histories.add(keyword);
    final data = {'keywords': histories};
    await myBox?.put(_searchHistory, json.encode(data));
  }

  Future<List> getHistory() async {
    final data = await myBox?.get(_searchHistory);

    if (data == null) return [];

    try {
      final jsons = json.decode(data as String);
      return jsons['keywords'] as List;
    } catch (e) {
      debugPrint('getHistory $e');
      return [];
    }
  }

  Future<void> deleteHistory(String keyword) async {
    if (keyword.isEmpty) return;

    final histories = await getHistory();
    histories.removeWhere((value) => value == keyword);
    final data = {'keywords': histories};
    await myBox?.put(_searchHistory, json.encode(data));
  }
}
