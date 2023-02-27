import 'package:base_project/helper/utils.dart';
import 'package:base_project/models/song_model.dart';

class DetailCategoryModel {
  DetailCategoryModel({
    this.songs,
    this.token,
  });

  bool? isSuccess;
  String? token;
  List<SongModel>? songs = [];

  DetailCategoryModel.fromJson(Map json) {
    isSuccess = json['success'] as bool;
    if (json.containsKey('more')) {
      final more = json['more'];
      token = more['token'] as String;
    }

    if (isSuccess!) {
      final dataPlain = Utils.decryptAESCrypto(json['data'] as String);
      songs = <SongModel>[];

      for (final v in dataPlain) {
        final title = v['name'];
        final channel = v['channel'];
        final url = v['img'];
        final videoId = v['video_id'];

        songs!.add(SongModel(
          songId: videoId as String,
          title: Utils.escape(title as String),
          channel: Utils.escape(channel as String),
          thumb: url as String,
        ));
      }
    }
  }
}
