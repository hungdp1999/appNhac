import 'dart:convert';
import 'dart:math';

import 'package:base_project/helper/const.dart';
import 'package:base_project/helper/utils.dart';
import 'package:base_project/helper/yt_plugin.dart';
import 'package:base_project/models/artist_model.dart';
import 'package:base_project/models/backup_data.dart';
import 'package:base_project/models/category_model.dart';
import 'package:base_project/models/detail_category_model.dart';
import 'package:base_project/models/device_model.dart';
import 'package:base_project/models/music_related_response.dart';
import 'package:base_project/models/network_request/asset_model.dart';
import 'package:base_project/models/network_request/backup_request.dart';
import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/models/song_model.dart';
import 'package:base_project/services/local_store/local_store.dart';
import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'network.dart';
import 'package:http/http.dart' as http;

import 'session_network.dart';

class ApiClient {
  static final ApiClient instance = ApiClient._init();

  ApiClient._init();

  final _unescape = HtmlUnescape();

  Future<List<PlaylistModel>> getTopPlayList(String countryCode) async {
    try {
      var url = ApiNote.getTopPlaylist;
      url += 'country_code=$countryCode';

      final response =
          await ApiNetwork.instance.get(url) as Map<String, dynamic>;

      if (response.containsKey('data')) {
        final data = Utils.decryptAESCrypto(response['data'] as String) as List;
        return data.map((f) => PlaylistModel.fromJson2(f as Map)).toList();
      }
      return [];
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return [];
    }
  }

  Future<List<ArtistModel>> getTopArtist(String countryCode) async {
    try {
      var url = ApiNote.getTopArtists;
      url += 'country_code=$countryCode';

      final response =
          await ApiNetwork.instance.get(url) as Map<String, dynamic>;
      if (response.containsKey('data')) {
        final data = Utils.decryptAESCrypto(response['data'] as String) as List;
        return data.map((f) => ArtistModel.fromJson(f as Map)).toList();
      }

      return [];
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return [];
    }
  }

  Future<List<ArtistModel>> getRelatedArtist(String countryCode) async {
    try {
      var url = ApiNote.getRelatedArtist;
      url += 'countryCode=$countryCode';

      final response =
          await ApiNetwork.instance.get(url) as Map<String, dynamic>;
      if (response.containsKey('data')) {
        final data = Utils.decryptAESCrypto(response['data'] as String) as List;
        return data.map((f) => ArtistModel.fromJson(f as Map)).toList();
      }

      return [];
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return [];
    }
  }

  Future<List<SongModel>> getTopTracks(String countryCode) async {
    try {
      var url = ApiNote.getMusicRecommend;
      url += 'country_code=$countryCode';
      final response =
          await ApiNetwork.instance.get(url) as Map<String, dynamic>;
      if (response.containsKey('data')) {
        final data = Utils.decryptAESCrypto(response['data'] as String) as List;
        return data.map((f) => SongModel.fromJson2(f as Map)).toList();
      }

      return [];
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return [];
    }
  }

  Future<Map<String, dynamic>> getTopNewTracks(String countryCode) async {
    try {
      var url = ApiNote.getNewTracks;
      url += 'country_code=$countryCode';

      return await ApiNetwork.instance.get(url) as Map<String, dynamic>;
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return {};
    }
  }

  Future<List<SongModel>> getTrending(String countryCode) async {
    try {
      var url = ApiNote.trending;
      url += 'country_code=$countryCode';
      final response =
          await ApiNetwork.instance.get(url) as Map<String, dynamic>;
      if (response.containsKey('data')) {
        final data = Utils.decryptAESCrypto(response['data'] as String) as List;
        return data.map((f) => SongModel.fromJson2(f as Map)).toList();
      }
      return [];
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return [];
    }
  }

  Future<PlaylistModel> getDetailPlaylist(String playlistId) async {
    final detailPlaylist =
        await YtPlugin.instance.getDetailPlaylist(playlistId);
    return detailPlaylist;
  }

  Future<DeviceModel?> getLocalDevice(String ip) async {
    try {
      final data = await ApiNetwork.instance.get('http://ip-api.com/json/$ip');
      return DeviceModel.fromJson(data as Map<String, dynamic>);
    } catch (e, stackTrace) {
      debugPrint('getLocalDevice $e - $stackTrace');
      return null;
    }
  }

  Future<List<String>> fetchSuggestion(String query) async {
    try {
      final region = await LocalStore.instance.getRegion();

      final url = '${ApiNote.getSuggestion}&q=$query';

      final fixUrl = url.replaceAll(':hl', region?.code ?? '');

      final response = await http.get(Uri(path: fixUrl));
      final datas = json.encode(response.body).split('],');

      final suggestions = <String>[];

      for (var i = 0; i < datas.length; i++) {
        final oj = datas[i].replaceAll('[', '').replaceAll(']', '');

        final singleObjects = oj.split(',');

        if (singleObjects != null && singleObjects.isNotEmpty) {
          if (singleObjects[0] is String && singleObjects[0].contains(' ')) {
            final data = _unescape.convert(
                singleObjects[0].replaceAll('"', '').replaceAll('\\', ''));

            suggestions.add(data);
          }

          if (i == 0 && singleObjects.length > 1) {
            if (singleObjects[1] is String && singleObjects[1].contains(' ')) {
              final data = _unescape.convert(
                  singleObjects[1].replaceAll('"', '').replaceAll('\\', ''));

              suggestions.add(data);
            }
          }
        }
      }
      return suggestions;
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      throw Exception(e);
    }
  }

  Future getCountries(BuildContext context) async {
    final countryString = await DefaultAssetBundle.of(context)
        .loadString('assets/configs/countries.json');
    return await json.decode(countryString);
  }

  Future<List<CategoryModel>?> getCatgories(BuildContext context) async {
    final topicString = await DefaultAssetBundle.of(context)
        .loadString('assets/configs/categories.json');

    final data = json.decode(topicString) as Map;
    final list = data['topic'] as List;
    return list.map((item) => CategoryModel.fromJson(item as Map)).toList();
  }

  Future<DetailCategoryModel?> getMusicsFromCategory(String genreCode) async {
    try {
      var url = ApiNote.getMusicFromCategory;
      url += 'genre_code=$genreCode';

      final response = await ApiNetwork.instance.get(url) as Map;

      if (response.containsKey('data')) {
        return DetailCategoryModel.fromJson(response);
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      return null;
    }
  }

  Future<List<SongModel>?> getWhoListening() async {
    try {
      final response = await ApiNetwork.instance.get(ApiNote.listening) as Map;

      if (response.containsKey('data')) {
        final data = response['data'] as List;
        return data.map((v) {
          final title = v['name'];
          final channel = v['channel'];
          final url = v['img'];
          final videoId = v['video_id'];

          return SongModel(
            songId: videoId as String,
            title: Utils.escape(title as String),
            channel: Utils.escape(channel as String),
            thumb: url as String,
          );
        }).toList();
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return null;
    }
  }

  Future<Map?> postWhoListening(SongModel? song) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': '__cfduid=dc975a37f267fe0f7d0646dee5fd58e521616482264'
    };
    final request = http.Request(
        'POST', Uri.parse('https://upbeat.famtechapp.info/listening/add'));
    request.bodyFields = {
      // 'name': song.title,
      // 'img': song.thumb,
      // 'channel': song.channel,
      // 'video_id': song.songId
    };

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      debugPrint(await response.stream.bytesToString());
    } else {
      debugPrint(response.reasonPhrase);
    }
    return null;
  }

  Future<DetailCategoryModel?> getDetailArtists(String id,
      {String? token}) async {
    try {
      var url = ApiNote.getDetailArtists;
      url += 'channel_id=$id';
      if (token != null) {
        url += '&token=$token';
      }
      final response = await ApiNetwork.instance.get(url) as Map;

      if (response.containsKey('data')) {
        return DetailCategoryModel.fromJson(response);
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('$e, $stackTrace');
      return null;
    }
  }

  Future<String?> generateBackupKey() async {
    final data =
        await ApiNetwork.instance.get(ApiNote.generateBackupKey) as Map;
    if (data['success'] as bool) {
      return data['data'] as String;
    }
    Utils.showToast('Generate Backup Key is error');
    return null;
  }

  Future<void> backupToCode(BackupRequest request) async {
    final data = await ApiNetwork.instance
        .post(ApiNote.createBackup, body: request.toJson()) as Map;

    debugPrint('backupToCode $data');

    if (!(data['success'] as bool)) {
      Utils.showToast('Backup is error');
    }
  }

  Future<Map<String, dynamic>?> restoreWithCode(String code) async {
    final data = await ApiNetwork.instance
        .get(ApiNote.restoreBackup, queries: {'code': code}) as Map;

    if (data['success'] as bool) {
      return data as Map<String, dynamic>;
    }

    Utils.showToast('Restore is error');
    return null;
  }

  Future<String?> sharePlaylist(BackupRequest request) async {
    final data = await ApiNetwork.instance
        .post(ApiNote.sharePlaylist, body: request.simpleToJson()) as Map;

    if (data['success'] as bool) {
      return data['data'] as String;
    }

    Utils.showToast('Share is error');
    return null;
  }

  Future<String?> handleBackupToCode() async {
    var backupData = await LocalStore.instance.getBackupKey();

    if (backupData == null) {
      final code = await generateBackupKey();
      if (code != null) {
        backupData = BackupData(code: code, lastBackup: DateTime.now());
        await LocalStore.instance.saveBackupKey(backupData);
      } else {
        throw Exception('Error Backup code');
      }
    }

    // final playlists = await AppDatabase.instance.getAllPlaylist();

    // if (playlists == null || playlists.isEmpty) {
    //   throw Exception('Nothing to backup');
    // }

    // final request = <Map<PlaylistModel, List<SongModel>>>[];
    // for (final playlist in playlists) {
    //   final updatePlaylist =
    //       await AppDatabase.instance.getSongsWithPlaylistId(playlist);
    //   request.add({playlist: updatePlaylist.songs});
    // }

    // await _saveLastTimeToLocal(request, backupData);

    // return backupData.code;
  }

  Future<void> _saveLastTimeToLocal(
      List<Map<PlaylistModel, List<SongModel>>> request,
      BackupData backupData) async {
    final code = backupData.code;
    final backupRequest = BackupRequest(code: code, playlists: request);

    await backupToCode(backupRequest);

    // save last time backed up
    final newBackup = BackupData(code: code, lastBackup: DateTime.now());
    LocalStore.instance.saveBackupKey(newBackup);
  }

  Future<List> searchChannel(String keyword, String type) async {
    final client = http.Client();
    try {
      final rapidkey = getRapidKey();
      final header = {
        "x-rapidapi-key": rapidkey,
        "x-rapidapi-host": "youtube-v31.p.rapidapi.com",
        'Content-Type': 'application/json'
      };

      final uriResponse = await client.get(
        Uri(
            path:
                'https://youtube-v31.p.rapidapi.com/search?q=$keyword&part=snippet%2Cid&maxResults=50&type=$type'),
        headers: header,
      );

      final responseJson =
          json.decode(utf8.decode(uriResponse.bodyBytes))['items'];

      return responseJson as List;
    } finally {
      client.close();
    }
  }

  Future<List> channelDetail(String channelId) async {
    final client = http.Client();
    try {
      final rapidkey = getRapidKey();
      final header = {
        "x-rapidapi-key": rapidkey,
        "x-rapidapi-host": "youtube-v31.p.rapidapi.com",
        'Content-Type': 'application/json'
      };

      final uriResponse = await client.get(
        Uri(
            path:
                'https://youtube-v31.p.rapidapi.com/channels?part=statistics&id=$channelId'),
        headers: header,
      );

      final responseJson =
          json.decode(utf8.decode(uriResponse.bodyBytes))['items'];

      debugPrint('responseJson $responseJson');
      return responseJson as List;
    } finally {
      client.close();
    }
  }

  Future<List> songDetail(String songId) async {
    final client = http.Client();
    try {
      final rapidkey = getRapidKey();
      final header = {
        "x-rapidapi-key": rapidkey,
        "x-rapidapi-host": "youtube-v31.p.rapidapi.com",
        'Content-Type': 'application/json'
      };

      final uriResponse = await client.get(
        Uri(
            path:
                'https://youtube-v31.p.rapidapi.com/videos?part=contentDetails%2Csnippet%2Cstatistics&id=$songId'),
        headers: header,
      );

      final responseJson =
          json.decode(utf8.decode(uriResponse.bodyBytes))['items'];

      debugPrint('responseJson $responseJson');
      return responseJson as List;
    } finally {
      client.close();
    }
  }

  String getRapidKey() {
    final index = Random().nextInt(Const.rapidKeys.length);
    return Const.rapidKeys[index];
  }

  Future<List<SongModel>?> getRelatedSong(SongModel music) async {
    try {
      var songs = await _getRelatedSongFromServer(music).timeout(
        const Duration(seconds: 8),
        onTimeout: () => [],
      );

      print('getRelatedSong $songs');

      /// get music from youtube api using token key

      if (songs!.isEmpty) {
        /// get musics from trending api
        final language = await LocalStore.instance.getRegion();
        songs = await getTrending(language?.code ?? 'US');

        if (songs.isEmpty) {
          throw 'Can not get Related Songs';
        }
      }

      return songs;
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      // Utils.showToast(LocaleKeys.canNotLoadPlaylist.tr());
      return null;
    }
  }

  Future<List<SongModel>?> _getRelatedSongFromServer(SongModel music,
      {String? videoId}) async {
    try {
      final html = await SessionNetwork.get(
          'https://www.youtube.com/watch?v=${music.songId ?? videoId}');

      final body = await SessionNetwork.post(
        ApiNote.relatedVideo,
        body: {'html': html, 'limit': '50'},
      );

      final jsonDecode = json.decode(body as String);
      if (jsonDecode['success'] as bool) {
        final response =
            MusicRelatedResponse.fromJson(jsonDecode as Map<String, dynamic>);
        return response.musics;
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      return null;
    }
  }

  Future<AssetModel?> getAsset(String songId) async {
    try {
      var url = ApiNote.getAssetsVideo;
      url += 'id=$songId';

//ytbserrver

      final response =
          await ApiNetwork.instance.get(url) as Map<String, dynamic>;
      debugPrint('getAsset abc :$response');
      if (response.containsKey('data')) {
        final data = Utils.decryptAESCrypto(response['data'] as String) as Map;
        final abc = await YtPlugin.instance.getLinks(songId);
        debugPrint('getAsset abc :$abc');

        data['mixVideos'] = abc['mixVideos'];
        final AssetModel model = AssetModel.fromJson(data);
        debugPrint('getAsset abc :${model.videos?.first..toString()}');

        return model;
      }

      return null;
    } catch (e, stackTrace) {
      debugPrint('=>>getAsset $e, $stackTrace');
      return null;
    }
  }
}
