import 'package:base_project/helper/const.dart';

class ApiNote {
  static const String register = '${Const.infoApi}/signup';
  static const String login = '${Const.infoApi}/login';
  static const String trending = '${Const.infoApi}/trending?';
  static const String getMusicRecommend = '${Const.infoApi}/popular?';
  static const String getTopPlaylist = '${Const.infoApi}/topplaylists?';
  static const String getNewTracks = '${Const.infoApi}/newtracks?';
  static const String getTopArtists = '${Const.infoApi}/topartists?';
  static const String listening = '${Const.infoApi}/listening?';
  static const String listeningAdd = '${Const.infoApi}/listening/add';
  static const String getDetailArtists = '${Const.infoApi}/channel/videos?';
  static const String generateBackupKey = '${Const.infoApi}/backup/generate';
  static const String createBackup = '${Const.infoApi}/backup/create';
  static const String restoreBackup = '${Const.infoApi}/backup/restore';
  static const String sharePlaylist = '${Const.infoApi}/playlist/share';
  static const String relatedVideo = '${Const.infoApi}/relateVideoId';
  static const String followArtist = '${Const.infoApi}/artists/follow';
  static const String getRelatedArtist = '${Const.infoApi}/artists/related?';
  static const String loginFb = '${Const.infoApi}/auth/facebook';
  static const String loginGoogle = '${Const.infoApi}/auth/google';

  // static const String loginFb =
  //     'https://www.facebook.com/v11.0/dialog/oauth?client_id=587942848866193&redirect_uri=${Const.infoApi}/facebook/auth-success&response_type=code&scope=public_profile,email';

  static const getSuggestion =
      'http://suggestqueries.google.com/complete/search?hl=:hl&ds=yt&client=youtube&hjson=t&cp=1&format=5&alt=json';
  static const getMusicFromCategory = '${Const.infoApi}/genre/videos?';

  static const String getAssetsVideo = '${Const.infoApi}/assets?';
}
