// ignore_for_file: unnecessary_null_comparison

import 'song_model.dart';

enum MusicKind { video, playlist }

class MusicRelatedResponse {
  MusicRelatedResponse.fromJson(Map<String, dynamic> json) {
    /// parse data from youtube server
    if (json['items'] != null) {
      musics = <SongModel>[];
      json['items'].forEach((v) {
        final item = Item.fromJson(v as Map<String, dynamic>);
        final id = item.videoId;
        final title = item.title;
        final isLive = item.isLive;
        final isVideo = item.kind == MusicKind.video;

        if (isVideo && id != null && title != null && !isLive!) {
          musics.add(SongModel.fromJson(item.toJson()));
        }
      });
    }

    /// parse json from famtech server
    if (json['data'] != null) {
      musics = <SongModel>[];
      json['data'].forEach((v) {
        final duration = v['duration'];
        if (duration != null) {
          musics.add(SongModel.fromJsonServer(v as Map));
        }
      });
    }
  }

  List<SongModel> musics = [];
}

class Item {
  Item.fromJson(Map<String, dynamic> json) {
    final id = json['id'] != null
        ? Id.fromJson(json['id'] as Map<String, dynamic>)
        : null;
    final snippet = json['snippet'] != null
        ? Snippet.fromJson(json['snippet'] as Map<String, dynamic>)
        : null;

    kind = id?.kind;
    videoId = id?.videoId;
    title = snippet?.title;
    isLive = snippet?.isLive;
    urlLow = snippet?.thumbnails!.urlLow;
    urlMedium = snippet?.thumbnails!.urlMedium;
    urlHigh = snippet?.thumbnails!.urlHigh;
    channelTitle = snippet?.channelTitle;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': videoId,
      'title': title,
      'channelTitle': channelTitle,
      'urlLow': urlLow,
      'urlMedium': urlMedium,
      'urlHigh': urlHigh,
    };
  }

  String? videoId;
  MusicKind? kind;
  String? urlLow;
  String? urlMedium;
  String? urlHigh;
  String? title;
  String? channelTitle;
  bool? isLive;
}

class Id {
  Id.fromJson(Map<String, dynamic> json) {
    kind =
        json['kind'] == 'youtube#video' ? MusicKind.video : MusicKind.playlist;
    videoId = json['videoId'] as String;
  }

  MusicKind? kind;
  String? videoId;
}

class Snippet {
  Snippet.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    thumbnails = json['thumbnails'] != null
        ? Thumbnails.fromJson(json['thumbnails'] as Map<String, dynamic>)
        : null;
    channelTitle = json['channelTitle'] as String;
    isLive = json['liveBroadcastContent'] == 'live';
  }

  String? title;
  Thumbnails? thumbnails;
  String? channelTitle;
  bool? isLive;
}

class Thumbnails {
  Thumbnails.fromJson(Map<String, dynamic> json) {
    urlLow = json['default'] != null ? json['default']['url'] as String : null;
    urlMedium = json['medium'] != null ? json['medium']['url'] as String : null;
    urlHigh = json['high'] != null ? json['high']['url'] as String : null;
  }

  String? urlLow;
  String? urlMedium;
  String? urlHigh;
}
