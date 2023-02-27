import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/models/song_model.dart';

class BackupRequest {
  BackupRequest({this.code, this.playlists});

  String? code;
  List<Map<PlaylistModel, List<SongModel>>>? playlists;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    final json = playlists!
        .map((e) => {
              'name': e.keys.first.title,
              'videos': e.values.first.map((e) => e.toJson2()).toList()
            })
        .toList();

    data['code'] = code;
    data['playlists'] = json;

    return data;
  }

  Map<String, dynamic> simpleToJson() {
    final data = <String, dynamic>{};

    final key = playlists!.first.keys.toList();
    final value = playlists!.first.values.toList();

    data['name'] = key.first.title;
    data['videos'] = value.first.map((e) => e.toJson2()).toList();

    return data;
  }
}
