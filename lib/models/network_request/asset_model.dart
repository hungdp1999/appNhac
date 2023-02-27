import 'dart:convert';

class AssetModel {
  final String ?id;
  final bool ?isLive;
  final String ?audioUrl;
  final String ?mixVideo;
  final String ?secondLength;
  final List<VideoModel> ?videos;

  AssetModel({
    this.id,
    this.isLive = false,
    this.audioUrl,
    this.mixVideo,
    this.secondLength,
    this.videos,
  });

  factory AssetModel.fromJson(Map data) {
    final videos = data['videos'] as List;
    final List<VideoModel> list = [];
    for (final video in videos) {
      list.add(
        VideoModel(
          quality: video['quality'] as String,
          url: video['url'] as String,
        ),
      );
    }

    return AssetModel(
      id: data['id'] as String,
      isLive: data['isLive'] as bool,
      audioUrl: data.containsKey('audio') ? data['audio'] as String : '',
      secondLength: data['duration'] as String,
      videos: list,
      mixVideo: data['mixVideo'] as String,
    );
  }

  @override
  String toString() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['isLive'] = isLive;

    if (audioUrl != null) {
      data['audioUrl'] = audioUrl;
    }

    if (secondLength != null) {
      data['secondLength'] = secondLength;
    }

    final _videos = [];

    if (videos != null) {
      for (final video in videos!) {
        _videos.add(video.toMap());
      }
      data['videos'] = _videos;
    }

    data['mixVideo'] = mixVideo;
    return json.encode(data);
  }
}

class VideoModel {
  final String ?quality;
  final String ?url;

  VideoModel({
    this.quality,
    this.url,
  });

  Map toMap() {
    return {'quality': quality, 'url': url};
  }
}
