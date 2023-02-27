import 'package:base_project/helper/utils.dart';

import 'song_model.dart';

class RecommendResponse {
  RecommendResponse({required this.musics});

  RecommendResponse.fromJson(Map<String, dynamic> json) {
    isSuccess = json['success'] as bool;

    final dataPlain = Utils.decryptAESCrypto(json['data'] as String);

    musics = <SongModel>[];

    for (final v in dataPlain) {
      final title = v['name'] as String;
      final channel = v['channel'] as String;
      final url = v['img'] as String;
      final videoId = v['video_id'] as String;

      musics.add(
        SongModel(
          songId: videoId,
          title: Utils.escape(title),
          channel: Utils.escape(channel),
          thumb: url,
        ),
      );
    }
  }

  bool? isSuccess;
  List<SongModel> musics = [];
}
