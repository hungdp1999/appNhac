import 'dart:convert';
import 'package:equatable/equatable.dart';

BackupData backupDataFromJson(String str) =>
    BackupData.fromJson(json.decode(str) as Map<String, dynamic>);

String backupDataToJson(BackupData data) => json.encode(data.toJson());

class BackupData extends Equatable {
  final String? code;
  final DateTime? lastBackup;

  const BackupData({this.code, this.lastBackup});

  factory BackupData.fromJson(Map<String, dynamic> json) => BackupData(
        code: json['code'] as String,
        lastBackup: json['lastBackup'] == null
            ? null
            : DateTime.parse(json['lastBackup'] as String),
      );

  factory BackupData.fromString(String data) {
    return BackupData.fromJson(json.decode(data));
  }

  Map<String, dynamic> toJson() =>
      {'code': code, 'lastBackup': lastBackup?.toIso8601String()};

  @override
  String toString() => json.encode(toJson());

  @override
  List<Object> get props => [code!, lastBackup!];
}
