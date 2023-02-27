import 'package:flutter/material.dart';

import 'package:base_project/helper/const.dart';
import 'package:base_project/models/song_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'shimmer/items/square_horizontal_item.dart';

class ListItem4x3View extends StatelessWidget {
  final List<SongModel> songs;

  const ListItem4x3View({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final length = songs.length > 12 ? 12 : songs.length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: Const.paddingHorizon,
        bottom: 24.h,
        top: Const.paddingHorizon.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          (length / 4).ceil(),
          (index) {
            final doubleIndex = index * 4;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (doubleIndex < length)
                  _buildItemTopTrack(doubleIndex, width, songs, context),
                if (doubleIndex + 1 < length)
                  _buildItemTopTrack(doubleIndex + 1, width, songs, context),
                if (doubleIndex + 2 < length)
                  _buildItemTopTrack(doubleIndex + 2, width, songs, context),
                if (doubleIndex + 3 < length)
                  _buildItemTopTrack(doubleIndex + 3, width, songs, context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildItemTopTrack(
    int index,
    double width,
    List<SongModel> songs,
    BuildContext context,
  ) {
    final song = songs[index];

    return Container(
      width: width * 0.85,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 5, right: 20),
      child: SquareHorizontalItem(
        sizeImage: Size(60.w, 40.h),
        image: song.thumb ?? '',
        title: song.title ?? '',
        subTitle: song.channel,
        // subMenu: OptionMenu(
        //   song: song,
        // ),
        onTap: () {
          // BlocProvider.of<ProPlayerCubit>(context)
          //     .open(song: song, songs: songs);
        },
      ),
    );
  }
}
