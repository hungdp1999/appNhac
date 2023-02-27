import 'dart:convert';

import 'package:base_project/models/artist_model.dart';
import 'package:base_project/models/music_related_response.dart';
import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/models/song_model.dart';
import 'package:base_project/network/api_network.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;

import 'const.dart';
import 'yt_helper.dart';

class YtPlugin {
  static final YtPlugin instance = YtPlugin._init();

  YtPlugin._init();
  SearchList? _searchList;
  YoutubeExplode? yt;

  String baseUrl = 'https://www.googleapis.com/youtube/v3';

  Future<Map> getLinks(String? videoId) async {
    if (videoId == null || videoId.isEmpty) return {};

    final ytExplore = YoutubeExplode();

    try {
      final streamInfo =
          await ytExplore.videos.streamsClient.getManifest(videoId);
      final mixVideos = streamInfo.muxed.sortByVideoQuality();
      final videos = streamInfo.videoOnly.sortByVideoQuality();
      final audios = streamInfo.audioOnly;

      final data = {
        "mixVideos": {
          // ignore: deprecated_member_use
          for (var v in mixVideos) v.videoQualityLabel: v.url.toString(),
        },
        "videos": {
          for (var v in videos) v.videoQualityLabel: v.url.toString(),
        },
        "audios": {
          for (var v in audios) v.bitrate: v.url.toString(),
        }
      };
      return data;
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      return {};
    } finally {
      ytExplore.close();
    }
  }

  Future<String> getBestVideo(Map? assets) async {
    if (assets == null) return '';

    final audios = assets['videos'] as Map;
    return audios.values.first as String;
  }

  String getBestMixVideo(Map? assets) {
    if (assets == null) return '';

    final audios = assets['mixVideos'] as Map;
    return audios.values.first as String;
  }

  Future<String> getBestAudio(Map? assets) async {
    if (assets == null) return '';

    final audios = assets['audios'] as Map;
    return audios.values.first as String;
  }

  String getVideoByResolution(Map? assets, String? resolution) {
    if (assets == null) return '';

    final audios = assets['videos'] as Map;
    return audios[resolution] as String;
  }

  List<String> getVideoQualityOptions(Map? assets) {
    if (assets == null) return [];
    final audios = assets['videos'] as Map;
    final List<String> audioQualities =
        audios.keys.map((lables) => lables.toString()).toList();
    audioQualities.sort((label1, label2) => int.parse(label1.split('p')[0])
        .compareTo(int.parse(label2.split('p')[0])));
    return audioQualities;
  }

  Future<PlaylistModel> getDetailPlaylist(String? playlistId) async {
    final ytExplore = YoutubeExplode();

    try {
      final playlist2 = await ytExplore.playlists.get(playlistId);

      final videos2 = await ytExplore.playlists.getVideos(playlistId).toList();

      return YtHelper.parsePlaylist(playlist2, videos2);
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      return PlaylistModel();
    } finally {
      ytExplore.close();
    }
  }

  void resetKeyword() {}

  void openYoutubeExplode() {
    _searchList = null;
    closeYoutubeExplode();
    yt = YoutubeExplode();
  }

  void closeYoutubeExplode() {
    _searchList = null;
    yt?.close();
  }

  Future<List<SongModel>> searchVideos(String keySearch) async {
    // openYoutubeExplode();
    // try {
    //   _searchList = (await yt.search.getVideos(keySearch)) as SearchList<BaseSearchContent>?;
    //   final songList = _searchList.map(YtHelper.videoToMusic).toList();
    //   return songList;
    // } catch (e) {
    return [];
    // }
  }

  Future<List<SongModel>> searchMoreVideos() async {
    // final nextser = await _searchList!.nextPage();
    // final songList = nextser!.map(YtHelper.videoToMusic).toList();
    // return songList;
    return [];
  }

  Future<SongModel> getInfoSong(String? songId) async {
    if (songId == null || songId.isEmpty) return SongModel();
    final url =
        "$baseUrl/videos?id=$songId&key=${Const.apiGoogleKey}&part=snippet,statistics";
    final data = await ApiNetwork.instance.get(url);
    final items = data['items'];
    final item = items[0];
    final id = item['id'];
    final snippet = item['snippet'];

    final title = snippet['title'];
    final channelTitle = snippet['channelTitle'];
    final channelId = snippet['channelId'];
    final thumb = snippet['thumbnails']['high']['url'];

    return SongModel(
      songId: id as String,
      title: title as String,
      channel: channelTitle as String,
      channelId: channelId as String,
      thumb: thumb as String,
    );
  }

  Future<ArtistModel> getInfoArtist({String? songId, String? channelId}) async {
    if (songId == null && channelId == null) {
      return ArtistModel();
    }

    String? id = channelId;
    if (channelId == null && songId != null) {
      final song = await getInfoSong(songId);
      id = song.channelId;
    }

    final url =
        "$baseUrl/channels?id=$id&key=${Const.apiGoogleKey}&part=snippet,statistics";

    final response = await http.get(
      Uri(path: url),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      final items = data['items'] as List;
      final item = items[0];
      final id = item['id'];
      final snippet = item['snippet'];
      final statistics = item['statistics'];

      final title = snippet['title'];
      final country = snippet['country'];
      final thumb = snippet['thumbnails']['high']['url'];
      final subscriberCount = statistics['subscriberCount'];
      final videoCount = statistics['subscriberCount'];
      return ArtistModel(
        name: title as String,
        channelId: id as String,
        country: country as String,
        imgPath: thumb as String,
        subscriberCount: subscriberCount as String,
        videoCount: videoCount as String,
      );
    }

    return ArtistModel();
  }

  Future<List<ArtistModel>?> getChannelsOfUser(String? token) async {
    final url =
        "$baseUrl/subscriptions?access_token=$token&key=${Const.apiGoogleKey}&part=snippet&mine=true";

    final data = await ApiNetwork.instance.get(url);
    final items = data['items'] as List;

    return ArtistModelList.fromYoutubeApi(items).list;
  }

  Future<bool> subscribe(String token, String id) async {
    try {
      final url =
          "$baseUrl/subscriptions?access_token=$token&key=${Const.apiGoogleKey}&part=snippet&mine=true";

      final body = {
        'snippet': {
          'resourceId': {
            'kind': 'youtube#channel',
            'channelId': id,
          }
        }
      };

      await ApiNetwork.instance.post(url, body: body);
      return true;
    } catch (e) {
      debugPrint('=>>>>>subscribe ${e.toString()}');
      return false;
    }
  }

  Future<bool> unsubscribe(String token, String channelId) async {
    try {
      final subscribeId = await checkSubscribeId(token, channelId);
      if (subscribeId != null) {
        final url =
            "$baseUrl/subscriptions?id=$subscribeId&access_token=$token&key=${Const.apiGoogleKey}&part=snippet&mine=true";

        await ApiNetwork.instance.delete(url);
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('=>>>>>unsubscribe ${e.toString()}');
      return false;
    }
  }

  Future<String?> checkSubscribeId(String token, String channelId) async {
    try {
      final url =
          "$baseUrl/subscriptions?forChannelId=$channelId&access_token=$token&key=${Const.apiGoogleKey}&part=snippet&mine=true";

      final data = await ApiNetwork.instance.get(url);
      final items = data['items'] as List;
      if (items.isEmpty) {
        return null;
      }

      return items.first['id'] as String;
    } catch (e) {
      debugPrint('=>>>>>unsubscribe ${e.toString()}');
      return null;
    }
  }

  Future<List<SongModel>?> getRelatedSong(SongModel? music,
      {String? token}) async {
    try {
      String url =
          "$baseUrl/search?key=${Const.apiGoogleKey}&part=snippet&type=video&maxResults=20&fields=nextPageToken, items(snippet/title,snippet/thumbnails,snippet/channelTitle, snippet/liveBroadcastContent,id)&relatedToVideoId=${music?.songId}";
      if (token != null) {
        url =
            "$baseUrl/search?access_token=$token&key=${Const.apiGoogleKey}&part=snippet&type=video&maxResults=20&fields=nextPageToken, items(snippet/title,snippet/thumbnails,snippet/channelTitle, snippet/liveBroadcastContent,id)&relatedToVideoId=${music?.songId}";
      }
      final res = await ApiNetwork.instance.get(url);
      final response =
          MusicRelatedResponse.fromJson(res as Map<String, dynamic>);
      if (response.musics.isEmpty) {
        return null;
      }

      return response.musics;
    } catch (e) {
      debugPrint('=>>>>>getRelatedSong ${e.toString()}');
      return null;
    }
  }
}
