import 'package:flutter/material.dart';

import 'package:base_project/components/header_more.dart';
import 'package:base_project/components/shimmer/items/square_vertical_item.dart';
import 'package:base_project/components/shimmer/square_vertical_shimmer.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/models/song_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopTracksThumb extends StatelessWidget {
  const TopTracksThumb({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AppCubit, AppState>(buildWhen: (prev, state) {
    //   return state is AppTrendingChangeState;
    // }, builder: (_, state) {
    //   //change region
    //   RegionModel _region;

    //   if (state is AppTrendingChangeState) {
    //     _region = state.region;
    //   }
    var songs = <SongModel>[];

    // create function
    void onSeeMore() {
      if (songs.isNotEmpty) {
        // Utils.navigatePage(
        //   context,
        //   TrackList(
        //     songs: toptracks,
        //     title: LocaleKeys.suggestedTracks.tr(),
        //   ),
        // );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderMore(
          title: 'suggestedTracks'.tr(),
          onSeeMore: onSeeMore,
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(
            left: Const.paddingHorizon,
            bottom: 24.h,
            top: Const.paddingHorizon.h,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: _fakeData(),
            builder: (context, snapshot) {
              var length = 4;
              final size = Size(110.h, 75.h);
              final isWaiting =
                  snapshot.connectionState == ConnectionState.waiting;

              if (snapshot.data != null) {
                songs = snapshot.data as List<SongModel>;
                length = songs.length > 5 ? 5 : songs.length;
              }

              return Row(
                children: List.generate(
                  length,
                  (index) {
                    if (isWaiting) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SquareVerticalShimmer(sizeImage: size),
                      );
                    }

                    final song = songs[index];
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SquareVerticalItem(
                        sizeImage: size,
                        image: song.thumb ?? '',
                        title: song.title ?? '',
                        subTitle: song.channel,
                        onTap: () {
                          // BlocProvider.of<ProPlayerCubit>(context)
                          //     .open(song: song,songs: toptracks);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
    // });
  }

  Future _fakeData() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      9,
      (index) => SongModel(
          thumb: 'https://img.youtube.com/vi/Ik0q1qPUddk/maxresdefault.jpg',
          title: 'Ai Cũng Có Ngày Xưa',
          channel: 'Phan Mạnh Quỳnh Official'),
    );
  }
}
