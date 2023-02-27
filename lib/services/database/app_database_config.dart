const String tablePlaylist = 'tablePlaylist';
const String tableSong = 'tableSong';
const String tablePlaylistSong = 'tablePlaylistSong';
const String tableRecentSong = 'tableRecentSong';
const String tableFavouritePlaylist = 'tableFavouritePlaylist';

class SongModelField {
  static const List<String> values = [
    id,
    songId,
    playlistId,
    title,
    channelId,
    channel,
    url,
    duration,
    thumb,
  ];

  static const String id = '_id';
  static const String songId = 'songId';
  static const String playlistId = 'playlistId';
  static const String title = 'title';
  static const String channelId = 'channelId';
  static const String channel = 'channel';
  static const String url = 'url';
  static const String duration = 'duration';
  static const String thumb = 'thumb';
  static const String playlistIdDb = 'playlistIdDb';
}

class PlaylistModelFields {
  static const List<String> values = [
    id,
    playlistId,
    title,
    thumb,
    duration,
    videoCount,
  ];

  static const String id = '_id';
  static const String playlistId = 'playlistId';
  static const String title = 'title';
  static const String thumb = 'thumb';
  static const String duration = 'duration';
  static const String videoCount = 'videoCount';
}
