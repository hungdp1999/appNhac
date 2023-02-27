import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/models/song_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as v2;

class YtHelper {
  static String formatDuration(Duration? duration) {
    if (duration == null) {
      return '00:00:00';
    }

    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    final twoDigitHours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours <= 0) {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }

    return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }

  static int parseYoutubeDurationToMs(String? duration) {
    var _duration = duration;

    try {
      if (_duration == null || _duration.isEmpty) {
        return 0;
      }

      _duration = _duration.toLowerCase().trim();

      var ms = 0;

      if (_duration.contains('h') && _duration.contains('m')) {
        final hour = int.tryParse(_getDataFromAToB(_duration, 'pt', 'h'));
        final minute = int.tryParse(_getDataFromAToB(_duration, 'h', 'm'));

        if (_duration.contains('s')) {
          final second = int.tryParse(_getDataFromAToB(_duration, 'm', 's'));
          ms += second!;
        }

        ms += hour! * 3600 + minute! * 60;
        ms *= 1000;
      } else if (_duration.contains('h') && !_duration.contains('m')) {
        final hour = int.tryParse(_getDataFromAToB(_duration, 'pt', 'h'));

        if (_duration.contains('s')) {
          final second = int.tryParse(_getDataFromAToB(_duration, 'h', 's'));
          ms += second!;
        }

        ms += hour! * 3600;
        ms *= 1000;
      } else if (!_duration.contains('h') && _duration.contains('m')) {
        final minute = int.tryParse(_getDataFromAToB(_duration, 'pt', 'm'));

        if (_duration.contains('s')) {
          final second = int.tryParse(_getDataFromAToB(_duration, 'm', 's'));
          ms += second!;
        }

        ms += minute! * 60;
        ms *= 1000;
      } else if (_duration.contains('s')) {
        final second = int.tryParse(_getDataFromAToB(_duration, 'pt', 's'));
        ms += second!;
        ms *= 1000;
      }

      return ms;
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      return 0;
    }
  }

  static String _getDataFromAToB(String source, String matchA, String matchB) {
    var startIndex = source.indexOf(matchA);
    final endIndex = source.indexOf(matchB);

    if (startIndex != -1 && endIndex != -1) {
      startIndex += matchA.length;
      return source.substring(startIndex, endIndex);
    }

    return '';
  }

  static String parseMsToString(int? duration) {
    var _duration = duration;
    try {
      if (_duration == null || _duration == 0) {
        return '00:00';
      } else {
        var format = '';
        final hour = (_duration / 3600000).floor();

        if (hour > 0) {
          format = '${_addZeroIfNeed(hour)}:';
          _duration -= hour * 3600000;
        }

        final minute = (_duration / 60000).floor();
        _duration -= minute * 60000;

        format += '${_addZeroIfNeed(minute)}:';

        final second = (_duration / 1000).floor();

        return format += _addZeroIfNeed(second);
      }
    } catch (e, stackTrace) {
      debugPrint('$e - $stackTrace');
      return '00:00';
    }
  }

  static String _addZeroIfNeed(int? data) {
    if (data == null) {
      return '00';
    } else if (data < 10) {
      return '0$data';
    }
    return '$data';
  }

  static SongModel videoToMusic(v2.Video? video) {
    if (video is v2.Video) {
      return SongModel(
        songId: video.id.value,
        // : video.thumbnails?.lowResUrl,
        // urlMedium: video.thumbnails?.mediumResUrl,
        thumb: video.thumbnails.highResUrl,
        title: video.title,
        channel: video.author,
        duration: video.duration?.inMilliseconds,
      );
    }

    return SongModel();
  }

  static PlaylistModel parsePlaylist(
      v2.Playlist? playlist, List<v2.Video>? videos) {
    if (playlist == null) {
      return PlaylistModel();
    }

    final songs = videos?.map(videoToMusic).toList();

    return PlaylistModel(
      playlistId: playlist.id.value,
      title: playlist.title,
      thumb: playlist.thumbnails.highResUrl,
      videoCount: songs?.length ?? 0,
      songs: songs,
    );
  }

  static String parsePlaylistId(String url) {
    if (url.isEmpty) {
      return '';
    }

    final index = url.lastIndexOf('list=');

    if (index != -1) {
      final subUrl = url.substring(index + 5);

      final indexCharacter = subUrl.indexOf('&');
      if (indexCharacter != -1) {
        return subUrl.substring(0, indexCharacter);
      } else {
        return subUrl;
      }
    }

    return '';
  }
}
