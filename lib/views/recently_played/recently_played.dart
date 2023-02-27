import 'package:base_project/components/header_more.dart';
import 'package:base_project/components/shimmer/items/square_vertical_item.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/models/song_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'rencetly_played_nodata.dart';

// import 'D:\/flutter/packages/flutter/lib/rendering.dart';
class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  List<SongModel> songs = [];

  // @override
  // void initState() {
  //   _playlistCubit = BlocProvider.of<PlaylistCubit>(context);
  //   _playlistCubit.getSongsRecently();
  //   _playlistCubit.listen((state) {
  //     if (state is PlaylistRecentlyUpdate) {
  //       debugPrint('PlaylistRecentlyUpdate');
  //       songs = state.songs;
  //       songs = songs.reversed.toList();
  //       setState(() {});
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    const double width = 105.0;
    const double height = 75.0;
    // final _widthItem = Utils.isDevicePhone()
    //     // ? ScreenUtil().setWidth(165)
    //     ? ScreenUtil().setWidth(80)
    //     // : ScreenUtil().setHeight(165);
    //     : ScreenUtil().setHeight(80);
    return songs.isEmpty
        ? const RecentlyPlayedNoData()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderMore(
                title: 'searchRecentlyPlayed'.tr(),
                onSeeMore: () {
                  // Utils.navigatePage(
                  //   context,
                  //   TrackList(
                  //     songs: songs,
                  //     title: LocaleKeys.searchRecentlyPlayed.tr(),
                  //   ),
                  // );
                },
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(Const.paddingHorizon),
                  bottom: 24.h,
                  top: ScreenUtil().setHeight(Const.paddingHorizon),
                ),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    songs.length + 1,
                    (index) {
                      if (index == songs.length) {
                        return const SizedBox(
                          width: width,
                          height: height,
                        );
                      }
                      final song = songs[index];
                      return Padding(
                        padding:
                            EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                        child: SquareVerticalItem(
                          sizeImage: const Size(width, height),
                          image: song.thumb ?? '',
                          // title: Utils.removeSpecialSymbols(song?.title),
                          title: song.title ?? '',
                          subTitle: song.channel,
                          onTap: () {
                            // BlocProvider.of<ProPlayerCubit>(context)
                            //     .open(song: song, songs: songs);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
