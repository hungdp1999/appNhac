import 'package:base_project/helper/utils.dart';
import 'package:base_project/services/database/app_database_config.dart';
import 'package:flutter/material.dart';

String thumbM(id) => "https://img.youtube.com/vi/$id/maxresdefault.jpg";

class SongModel {
  final int? id;
  final String? songId;
  final String? playlistId;
  final String? channelId;
  final String? title;
  final String? channel;
  final String? url;
  final int? duration;
  final String? thumb;
  int? playlistIdDb;

  SongModel({
    this.id,
    this.songId,
    this.playlistId,
    this.channelId,
    this.title,
    this.channel,
    this.url,
    this.duration = 0,
    this.thumb,
    this.playlistIdDb,
  });

  factory SongModel.fromJson(Map json) {
    return SongModel(
      id: json[SongModelField.id] as int,
      songId: json[SongModelField.songId] as String,
      playlistId: json[SongModelField.playlistId] as String,
      channelId: json[SongModelField.channelId] as String,
      title: json[SongModelField.title] as String,
      channel: json[SongModelField.channel] as String,
      url: json[SongModelField.url] as String,
      duration: json[SongModelField.duration] as int,
      thumb: json[SongModelField.thumb] as String,
      playlistIdDb: json[SongModelField.playlistIdDb] as int,
    );
  }

  factory SongModel.fromJson2(Map json) {
    final String songId = json['video_id'] as String;
    return SongModel(
      id: json['id'] as int,
      songId: songId,
      title: json['name'] as String,
      channel: json['channel'] as String,
      thumb: thumbM(songId),
    );
  }

  factory SongModel.fromJsonServer(Map json) {
    final String songId = json['id'] as String;
    return SongModel(
      songId: songId,
      title: Utils.escape(json['title'] as String),
      duration: (json['duration']) * 1000,
      thumb: thumbM(songId),
      channel: Utils.escape(
          json['channel'] != null ? json['channel']['name'] as String : null),
    );
  }

  SongModel copy(
      {int? id,
      String? songId,
      String? playlistId,
      String? channelId,
      String? title,
      String? channel,
      String? url,
      int? duration,
      String? thumb,
      int? playlistIdDb}) {
    return SongModel(
        id: id ?? this.id,
        songId: songId ?? this.songId,
        playlistId: playlistId ?? this.playlistId,
        channelId: channelId ?? this.channelId,
        title: title ?? this.title,
        channel: channel ?? this.channel,
        url: url ?? this.url,
        duration: duration ?? this.duration,
        thumb: thumb ?? this.thumb,
        playlistIdDb: playlistIdDb ?? this.playlistIdDb);
  }

  Map<String, dynamic> toJson() => {
        SongModelField.id: id,
        SongModelField.songId: songId ?? '',
        SongModelField.playlistId: playlistId ?? '',
        SongModelField.channelId: channelId ?? '',
        SongModelField.channel: channel ?? '',
        SongModelField.title: title ?? '',
        SongModelField.url: url ?? '',
        SongModelField.duration: duration ?? 0,
        SongModelField.thumb: thumb ?? '',
      };

  Map<String, dynamic> toJson2() {
    return <String, dynamic>{
      'video_id': songId,
      'name': title,
      'channel': channel,
      'img': thumb,
    };
  }
}

class SongModelList {
  List<SongModel>? list;

  SongModelList({this.list});

  factory SongModelList.fromDataBase(List<Map> datas) {
    List<SongModel> list = [];
    try {
      list = datas.map((f) => SongModel.fromJson(f)).toList();
    } catch (e, stack) {
      debugPrint('SongModelList $e - $stack');
    }
    return SongModelList(list: list);
  }

  // factory PlaylistModelList.fromRapidApi(List datas) {
  //   List<PlaylistModel> list = List();
  //   try {
  //     list = datas.map((f) => PlaylistModel.fromRapidApi(f)).toList();
  //   } catch (e, stack) {
  //     debugPrint('$e - $stack');
  //   }
  //   return PlaylistModelList(list: list);
  // }
}
