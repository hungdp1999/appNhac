import 'package:flutter/material.dart';

class ArtistModel {
  final int ?id;
  final String ?country;
  final String ?name;
  final String ?imgPath;
  final String ?channelId;
  final String ?subscriberCount;
  final String ?videoCount;

  ArtistModel({
    this.id,
    this.country,
    this.name,
    this.imgPath,
    this.channelId,
    this.subscriberCount,
    this.videoCount,
  });

  factory ArtistModel.fromJson(Map json) {
    return ArtistModel(
      id: json['id'] as int,
      country: json['country'] as String,
      name: json['name'] as String,
      imgPath: json['img'] as String,
      channelId: json['channel_id'] as String,
    );
  }

  factory ArtistModel.fromRapidApi(Map json) {
    final snippet = json['snippet'];
    return ArtistModel(
      channelId: snippet['channelId'] as String,
      name: snippet['channelTitle'] as String,
      imgPath: snippet['thumbnails']['medium']['url'] as String,
    );
  }

  factory ArtistModel.fromYoutubeApi(Map json) {
    final snippet = json['snippet'];
    return ArtistModel(
      channelId: snippet['resourceId']['channelId'] as String,
      name: snippet['title'] as String,
      imgPath: snippet['thumbnails']['medium']['url'] as String,
    );
  }
}

class ArtistModelList {
  List<ArtistModel>? list;

  ArtistModelList({this.list});

  factory ArtistModelList.fromJson(List datas) {
    List<ArtistModel> list = [];
    try {
      list = datas.map((f) => ArtistModel.fromJson(f as Map)).toList();
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
    return ArtistModelList(list: list);
  }

  factory ArtistModelList.fromRapidApi(List datas) {
    List<ArtistModel> list = [];
    try {
      list = datas.map((f) => ArtistModel.fromRapidApi(f as Map)).toList();
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
    return ArtistModelList(list: list);
  }

  factory ArtistModelList.fromYoutubeApi(List datas) {
    List<ArtistModel> list = [];
    try {
      list = datas.map((f) => ArtistModel.fromYoutubeApi(f as Map)).toList();
    } catch (e, stack) {
      debugPrint('$e - $stack');
    }
    return ArtistModelList(list: list);
  }
}
