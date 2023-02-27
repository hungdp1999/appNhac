import 'package:base_project/services/database/app_database_config.dart';
import 'package:flutter/material.dart';

import 'song_model.dart';

class PlaylistModel {
  final int? id;
  final String? playlistId;
  final String? title;
  final String? thumb;
  final int? duration;
  final int? videoCount;
  final List<SongModel>? songs;

  PlaylistModel({
    this.id,
    this.playlistId,
    this.title,
    this.thumb,
    this.duration = 0,
    this.videoCount = 0,
    this.songs,
  });

  factory PlaylistModel.fromJson(Map json) {
    return PlaylistModel(
      id: json[PlaylistModelFields.id] as int,
      playlistId: json[PlaylistModelFields.playlistId] as String,
      title: json[PlaylistModelFields.title] as String,
      thumb: json[PlaylistModelFields.thumb] as String,
      duration: json[PlaylistModelFields.duration] as int,
      videoCount: json[PlaylistModelFields.videoCount] as int,
    );
  }

  factory PlaylistModel.fromJson2(Map json) {
    return PlaylistModel(
      playlistId: json['id'] as String,
      title: json['title'] as String,
      thumb: json['img'] as String,
      videoCount: json['videoCount'] as int,
    );
  }

  factory PlaylistModel.fromRapidApi(Map? json) {
    if (json == null) return PlaylistModel();
    final id = json['id']['playlistId'];
    final snippet = json['snippet'];
    return PlaylistModel(
      playlistId: id as String,
      title: snippet['title'] as String,
      videoCount: json.containsKey('videoCount')
          ? json.containsKey('videoCount') as int
          : null,
      thumb: snippet["thumbnails"]['medium']['url'] as String,
    );
  }

  PlaylistModel copy({
    int? id,
    String? playlistId,
    String? title,
    int? duration,
    String? thumb,
    int? videoCount,
    List<SongModel>? songs,
  }) {
    return PlaylistModel(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      title: title ?? this.title,
      thumb: thumb ?? this.thumb,
      duration: duration ?? this.duration,
      videoCount: videoCount ?? this.videoCount,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toJson() => {
        PlaylistModelFields.id: id,
        PlaylistModelFields.playlistId: playlistId,
        PlaylistModelFields.title: title,
        PlaylistModelFields.thumb: thumb,
        PlaylistModelFields.duration: duration,
        PlaylistModelFields.videoCount: videoCount,
      };
}

class PlaylistModelList {
  List<PlaylistModel>? list;

  PlaylistModelList({this.list});

  factory PlaylistModelList.fromDataBase(List<Map> datas) {
    List<PlaylistModel> list = [];
    try {
      list = datas.map((f) => PlaylistModel.fromJson(f)).toList();
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
    return PlaylistModelList(list: list);
  }

  factory PlaylistModelList.fromRapidApi(List datas) {
    List<PlaylistModel> list = [];
    try {
      list = datas.map((f) => PlaylistModel.fromRapidApi(f as Map)).toList();
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
    return PlaylistModelList(list: list);
  }
}
