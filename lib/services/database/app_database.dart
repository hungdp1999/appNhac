// import 'package:flutter/material.dart';
// import 'package:upbeat_v2/models/playlist_model.dart';
// import 'package:upbeat_v2/models/song_model.dart';
// import 'package:sqflite/sqflite.dart';

// import 'app_database_config.dart';

// class AppDatabase {
//   static final AppDatabase instance = AppDatabase._init();

//   static Database _database;

//   AppDatabase._init();

//   Future<Database> get database async {
//     if (_database != null) return _database;

//     return _database = await _initDB('playlist.db');
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = '$dbPath/$filePath';
//     // final path =
//     //     '/Users/balua/Documents/FlutterProjects/listenit-mobile/assets/' +
//     //         filePath;
//     final db = await openDatabase(path, version: 1, onCreate: _onCreateDB);
//     return db;
//   }

//   Future _onCreateDB(Database db, int version) async {
//     const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
//     const textType = 'TEXT';
//     const intType = 'INTEGER';

//     db.execute('''
//     CREATE TABLE $tablePlaylist (
//           ${PlaylistModelFields.id} $idType, 
//           ${PlaylistModelFields.playlistId} $textType, 
//           ${PlaylistModelFields.title} $textType, 
//           ${PlaylistModelFields.thumb} $textType, 
//           ${PlaylistModelFields.duration} $intType, 
//           ${PlaylistModelFields.videoCount} $intType)
//           ''');

//     db.execute('''
//       CREATE TABLE $tableSong (
//         ${SongModelField.id} $idType,
//         ${SongModelField.songId} $textType,
//         ${SongModelField.playlistId} $textType,
//         ${SongModelField.title} $textType,
//         ${SongModelField.channelId} $textType,
//         ${SongModelField.channel} $textType,
//         ${SongModelField.url} $textType,
//         ${SongModelField.duration} $intType,
//         ${SongModelField.thumb} $textType)
//       ''');

//     db.execute('''
//       CREATE TABLE $tablePlaylistSong (
//         ${SongModelField.id} $idType,
//         ${PlaylistModelFields.playlistId} $textType,
//         ${SongModelField.songId} $textType,
//         ${'position'} $intType)
//       ''');

//     db.execute('''
//       CREATE TABLE $tableRecentSong (
//         ${SongModelField.id} $idType,
//         ${SongModelField.songId} $textType,
//         ${SongModelField.playlistId} $textType,
//         ${SongModelField.title} $textType,
//         ${SongModelField.channelId} $textType,
//         ${SongModelField.channel} $textType,
//         ${SongModelField.url} $textType,
//         ${SongModelField.duration} $intType,
//         ${SongModelField.thumb} $textType)
//       ''');
//   }

//   Future<PlaylistModel> createPlaylist(String title) async {
//     final db = await instance.database;
//     //create playlistId with timestame
//     final playlistId = DateTime.now().millisecondsSinceEpoch.toString();
//     final playlist = PlaylistModel(playlistId: playlistId, title: title);
//     //insert db
//     final index = await db.insert(tablePlaylist, playlist.toJson());
//     return playlist.copy(id: index);
//   }

//   Future<PlaylistModel> updatePlaylist(
//     String playlistId, {
//     String title,
//     int duration,
//     int countSong,
//     String thumb,
//   }) async {
//     final playlist = await getPlaylistWithId(playlistId);
//     if (playlist != null) {
//       final db = await instance.database;
//       await db.rawUpdate(
//         '''
//         UPDATE $tablePlaylist SET 
//         ${PlaylistModelFields.title} = ?, 
//         ${PlaylistModelFields.duration} = ?, 
//         ${PlaylistModelFields.videoCount} = ? ,
//         ${PlaylistModelFields.thumb} = ? 
//         WHERE ${PlaylistModelFields.playlistId} = ?
//         ''',
//         [
//           title ?? playlist.title,
//           duration ?? playlist.duration,
//           countSong ?? playlist.videoCount,
//           thumb,
//           playlistId
//         ],
//       );
//       final updatedPlaylist = await getPlaylistWithId(playlistId);
//       return updatedPlaylist;
//     }
//     return null;
//   }

//   Future<void> deletePlaylist(String playlistId) async {
//     final db = await instance.database;
//     //remove song at tablePlalistSong
//     await db.rawQuery('''
//         DELETE FROM $tablePlaylistSong WHERE ${PlaylistModelFields.playlistId} = $playlistId
//       ''');
//     //remove playlist from tablePlaylist
//     await db
//         .rawQuery('DELETE FROM $tablePlaylist WHERE playlistId = $playlistId');

//     //remove all songs not reference to any table
//     await db.rawQuery('''
//       DELETE FROM $tableSong WHERE songID NOT IN (SELECT songID FROM $tablePlaylistSong)
//       ''');
//   }

//   Future<bool> existPlaylist(String title) async {
//     try {
//       final db = await instance.database;
//       final list = await db.query(
//         tablePlaylist,
//         where: '${PlaylistModelFields.title} = ?',
//         whereArgs: [title],
//       );
//       return list.isNotEmpty;
//     } catch (e) {
//       debugPrint('existPlaylist $e');

//       return false;
//     }
//   }

//   Future<bool> existPlaylistId(String playlistId) async {
//     final db = await instance.database;
//     final list = await db.query(
//       tablePlaylist,
//       where: '${PlaylistModelFields.playlistId} = ?',
//       whereArgs: [playlistId],
//     );
//     return list.isNotEmpty;
//   }

//   Future<List<PlaylistModel>> getAllPlaylist() async {
//     final db = await instance.database;
//     final list = await db.query(
//       tablePlaylist,
//       columns: PlaylistModelFields.values,
//     );

//     return PlaylistModelList.fromDataBase(list).list;
//   }

//   Future<PlaylistModel> getPlaylistWithName(String title) async {
//     final db = await instance.database;
//     final playlists = await db.query(
//       tablePlaylist,
//       where: '${PlaylistModelFields.title} = ?',
//       whereArgs: [title],
//     );

//     if (playlists.isNotEmpty) {
//       return PlaylistModel.fromJson(playlists.first);
//     } else {
//       throw Exception('Not Found Playlist Name $title');
//     }
//   }

//   Future<PlaylistModel> getPlaylistWithId(String playlistId) async {
//     final db = await instance.database;
//     final playlists = await db.query(
//       tablePlaylist,
//       where: '${PlaylistModelFields.playlistId} = ?',
//       whereArgs: [playlistId],
//     );

//     if (playlists.isNotEmpty) {
//       return PlaylistModel.fromJson(playlists.first);
//     } else {
//       throw Exception('Not Found Playlist Id $playlistId');
//     }
//   }

//   Future<List<SongModel>> getAllSong() async {
//     final db = await instance.database;
//     final list = await db.query(tableSong);
//     return SongModelList.fromDataBase(list).list;
//   }

//   Future<PlaylistModel> getSongsWithPlaylistId(PlaylistModel playlist) async {
//     final db = await instance.database;
//     final list = await db.rawQuery('''
//       SELECT * FROM $tablePlaylistSong tbPS
//       INNER JOIN $tableSong tbS ON tbPS.songId = tbS.songId and tbPS.playlistId = ${playlist.playlistId}
//       ORDER BY position
//     ''');

//     final fixList = list.toSet().toList();
//     final songs = SongModelList.fromDataBase(fixList).list;
//     return playlist.copy(songs: songs);
//   }

//   Future<bool> addSongToPlaylist(String playlistId, SongModel song) async {
//     // debugPrint('[AppDatabase] start add song to playlist');
//     if (playlistId == null) throw Exception('playlistId not null');

//     final existSong = await songExistWithPlaylist(playlistId, song.songId);
//     // debugPrint('[AppDatabase] is song exist in playlist: $existSong');
//     try {
//       if (!existSong) {
//         final db = await instance.database;

//         // get list songs in playlist to create new position.
//         final list = await db.rawQuery('''
//         SELECT * FROM $tablePlaylistSong tbPS
//         INNER JOIN $tableSong tbS ON tbPS.songId = tbS.songId and tbPS.playlistId = ${playlistId}
//         ORDER BY position
//       ''');

//         //check song exist in tablesong?
//         if (!await songExistInTable(tableSong, song.songId)) {
//           //insert song to tablesong
//           await db.insert(tableSong, song.toJson());
//         }

//         final Map item = {
//           PlaylistModelFields.playlistId: playlistId,
//           SongModelField.songId: song.songId,
//           'position': list.length
//         };
//         // debugPrint(
//         //     '[AppDatabase] add item to tablePlayListSong ${item.toString()}');
//         //add key playlistid and song id to manager
//         await db.insert(tablePlaylistSong, {
//           PlaylistModelFields.playlistId: playlistId,
//           SongModelField.songId: song.songId,
//           'position': list.length
//         });

//         //update playlist when new song added to a playlist
//         final playlist = await getPlaylistWithId(playlistId);
//         await updatePlaylist(
//           playlistId,
//           duration: playlist.duration + song.duration,
//           countSong: playlist.videoCount + 1,
//           thumb: playlist.thumb ?? song.thumb
//           // playlist.title != Const.name_favourite
//           //     ? playlist.thumb ?? song.thumb
//           //     : null,
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       debugPrint('[AppDatabase] Exception addSongToPlaylist $e');
//       return false;
//     }
//   }

//   Future<bool> changePositionSongInPlaylist(
//       String playlistId, int oldIndex, int newIndex) async {
//     final db = await instance.database;
//     try {
//       final fullList = await db.rawQuery('''
//         SELECT * FROM $tablePlaylistSong
//         ''');
//       // debugPrint('[AppDatabase] ${fullList.toString()}');

//       final list = await db.rawQuery(
//         '''
//         SELECT * FROM $tablePlaylistSong WHERE ${PlaylistModelFields.playlistId} = ? and position = ?
//         ''',
//         [playlistId, oldIndex],
//       );

//       final fixList = list.toSet().toList();
//       final songs = SongModelList.fromDataBase(fixList).list;

//       await db.rawUpdate('''
//         UPDATE $tablePlaylistSong SET 
//         position = position ${newIndex < oldIndex ? '+' : '-'} 1
//         WHERE ${PlaylistModelFields.playlistId} = ?
//         AND position >= ${newIndex < oldIndex ? newIndex : oldIndex} 
//         AND position <= ${newIndex < oldIndex ? oldIndex : newIndex}
//         ''', [playlistId]);

//       await db.rawUpdate('''
//         UPDATE $tablePlaylistSong SET 
//         position = ? 
//         WHERE ${PlaylistModelFields.playlistId} = ?
//         AND ${SongModelField.songId} = ?         
//         ''', [newIndex, playlistId, songs[0].songId]);
//       return true;
//     } catch (e) {
//       debugPrint(
//           '[AppDatabase] exeption when change position song: ${e.toString()}}');
//       return false;
//     }
//   }

//   Future<bool> removeSongFromPlaylist(String playlistId, SongModel song) async {
//     if (playlistId == null || song == null) {
//       throw Exception('[AppDatabase] playlistId not null');
//     }

//     final existSong = await songExistWithPlaylist(playlistId, song.songId);
//     try {
//       if (existSong) {
//         final db = await instance.database;
//         //remove song at tablePlalistSong
//         await db.rawDelete(
//           '''
//         DELETE FROM $tablePlaylistSong WHERE ${PlaylistModelFields.playlistId} = ? and ${SongModelField.songId} = ?
//       ''',
//           [playlistId, song.songId],
//         );

//         //check bai hat k bi thua
//         await db.rawQuery('''
//       DELETE FROM $tableSong WHERE songID NOT IN (SELECT songID FROM $tablePlaylistSong)
//       ''');

//         //update playlist when new song added to a playlist
//         final playlist = await getPlaylistWithId(playlistId);
//         final count = playlist.videoCount - 1;
//         print('=>>>>>> count $count');
//         await updatePlaylist(
//           playlistId,
//           duration: playlist.duration - song.duration,
//           countSong: count,
//           thumb: count == 0 ? null : playlist.thumb,
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       debugPrint('Exception removeSongFromPlaylist $e');
//       return false;
//     }
//   }

//   Future<bool> songExistInTable(String nameTable, String songId) async {
//     final db = await instance.database;
//     final list = await db.rawQuery(
//       '''
//         SELECT * FROM $nameTable WHERE ${SongModelField.songId} = ?
//       ''',
//       [songId],
//     );
//     return list.isNotEmpty;
//   }

//   Future<bool> songExistWithPlaylist(String playlistId, String songId) async {
//     if (playlistId == null || songId == null) return false;

//     final db = await instance.database;

//     final list = await db.rawQuery(
//       '''
//     SELECT * FROM $tablePlaylistSong WHERE ${PlaylistModelFields.playlistId} = ? and ${SongModelField.songId} = ?
//   ''',
//       [playlistId, songId],
//     );

//     return list.isNotEmpty;
//   }

//   ///
//   ///add/remove song to table recently/favourite playlist
//   ///

//   Future<bool> addSongToTable(String nameTable, SongModel song) async {
//     final db = await instance.database;
//     try {
//       //check song exist in tablesong?
//       if (!await songExistInTable(nameTable, song.songId)) {
//         //insert song to tablesong
//         final index = await db.insert(tableSong, song.toJson());
//         return index != null;
//       }
//       return false;
//     } catch (e) {
//       debugPrint('addSongToTable $e');
//       return false;
//     }
//   }

//   Future<bool> removeSongToTable(String nameTable, SongModel song) async {
//     final db = await instance.database;

//     try {
//       //check song exist in tablesong?

//       if (await songExistInTable(nameTable, song.songId)) {
//         //delete
//         await db.rawQuery(
//           '''
//       DELETE FROM $nameTable WHERE ${SongModelField.songId} = ?
//       ''',
//           [song.songId],
//         );
//         return true;
//       }
//       return false;
//     } catch (e) {
//       debugPrint('removeSongToTable $e');
//       return false;
//     }
//   }

//   Future<bool> addSongRecently(SongModel song) async {
//     try {
//       final db = await instance.database;
//       final isExist = await songExistInTable(tableRecentSong, song.songId);
//       if (isExist) {
//         await removeSongToTable(tableRecentSong, song);
//       }
//       final index = await db.insert(tableRecentSong, song.toJson());
//       return index != null;
//     } catch (e) {
//       debugPrint('addSongRecently $e');
//       return false;
//     }
//   }

//   Future<List<SongModel>> getSongsRecently() async {
//     try {
//       return await getAllSongTable(tableRecentSong);
//     } catch (e) {
//       debugPrint('getSongsRecently $e');
//       return [];
//     }
//   }

//   Future<List<SongModel>> getAllSongTable(String nameTable) async {
//     final db = await instance.database;
//     final list = await db.query(nameTable);
//     return SongModelList.fromDataBase(list).list;
//   }

//   Future<void> clearAllData() async {
//     final db = await instance.database;
//     await db.delete(tablePlaylistSong);
//     await db.delete(tablePlaylist);
//     await db.delete(tableSong);
//   }

//   Future close() async {
//     final db = await instance.database;
//     db.close();
//   }
// }
