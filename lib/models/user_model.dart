import 'dart:convert';

import 'package:flutter/material.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? accessToken;
  final String? avatar;
  final String? backupCode;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.accessToken,
    this.avatar,
    this.backupCode,
  });

  factory UserModel.fromJson(Map json) {
    final profile = json['profile'];
    try {
      return UserModel(
        id: profile['id'] as String,
        name: profile['displayName'] as String,
        avatar: profile['avatarUrl'] as String,
        backupCode: profile['backupCode'] as String,
        accessToken: json['accessToken'] as String,
      );
    } catch (e) {
      debugPrint(e.toString());
      return UserModel();
    }
  }

  factory UserModel.fromSocialJson(Map json) {
    try {
      return UserModel(
        id: json['refId'] as String,
        name: json['displayName'] as String,
        avatar: json['avatarUrl'] as String,
        accessToken: json['accessToken'] as String,
        backupCode: json['backupCode'] as String,
      );
    } catch (e) {
      debugPrint(e.toString());
      return UserModel();
    }
  }

  UserModel copy({
    String? name,
    String? email,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      accessToken: accessToken,
      avatar: avatar,
      backupCode: backupCode,
    );
  }

  String toJson() {
    final profile = {
      'id': id,
      'displayName': name,
      'avatarUrl': avatar ?? '',
      'backupCode': backupCode,
    };

    final map = {
      'accessToken': accessToken,
      'profile': profile,
    };
    return json.encode(map);
  }
}
