import 'package:base_project/components/header_more.dart';
import 'package:base_project/components/shimmer/items/square_horizontal_item.dart';
import 'package:base_project/components/shimmer/square_vertical_shimmer.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/helper/utils.dart';
import 'package:base_project/models/song_model.dart';
import 'package:base_project/views/track_list/track_list.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopTracks4x3 extends StatelessWidget {
  const TopTracks4x3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // return BlocBuilder<AppCubit, AppState>(buildWhen: (prev, state) {
    //   return state is AppTrendingChangeState;
    // }, builder: (_, state) {
    //   //change region
    //   RegionModel _region;

    //   if (state is AppTrendingChangeState) {
    //     _region = state.region;
    //   }

    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: StreamBuilder(
        stream: Stream.fromFuture(_fakeData()),
        builder: (_, snapshot) {
          List<SongModel> toptracks = [];
          final isWaiting = snapshot.connectionState == ConnectionState.waiting;
          int length = 12;
          if (snapshot.data != null) {
            toptracks = snapshot.data as List<SongModel>;
            length = toptracks.length;
          }

          //empty is hiden
          if (length == 0) return const SizedBox.shrink();

          // ignore: unused_local_variable
          final sizeImage = Utils.isDevicePhone()
              ? ScreenUtil().setWidth(65)
              : ScreenUtil().setHeight(50);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderMore(
                title: 'topTracks'.tr(),
                // LocaleKeys.topTracks.tr(),
                onSeeMore: () {
                  Utils.navigatePage(
                    context,
                    TrackList(songs: toptracks, title: 'topTracks'.tr()
                        // LocaleKeys.topTracks.tr(),
                        ),
                  );
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  // left: Const.padding_horizon,
                  bottom: ScreenUtil().setHeight(24),
                  top: ScreenUtil().setHeight(Const.paddingHorizon.w),
                ),
                child: Row(
                  children: List.generate(
                    ((length > 12 ? 12 : length) / 4).ceil(),
                    (index) {
                      if (isWaiting) {
                        return Padding(
                          padding:
                              EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                          child: Column(
                            children: [
                              _squareVerticalShimmer(),
                              _squareVerticalShimmer(),
                              _squareVerticalShimmer(),
                              _squareVerticalShimmer(),
                            ],
                          ),
                        );
                      }
                      final doubleIndex = index * 4;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (doubleIndex < length)
                            _buildItemTopTrack(
                                doubleIndex, width, toptracks, context),
                          if (doubleIndex + 1 < length)
                            _buildItemTopTrack(
                                doubleIndex + 1, width, toptracks, context),
                          if (doubleIndex + 2 < length)
                            _buildItemTopTrack(
                                doubleIndex + 2, width, toptracks, context),
                          if (doubleIndex + 3 < length)
                            _buildItemTopTrack(
                                doubleIndex + 3, width, toptracks, context),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
    // });
  }

  Future _fakeData() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
      12,
      (index) => SongModel(
          thumb: 'https://img.youtube.com/vi/W4P8gl4dnrg/maxresdefault.jpg',
          title: 'MỸ TÂM - HẸN ƯỚC TỪ HƯ VÔ (LIVE) | MY SOUL 1981',
          channel: 'My Tam'),
    );
  }

  Widget _squareVerticalShimmer() {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: SquareVerticalShimmer(
        sizeImage: Size(
          300.w,
          15.h,
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
    final sizeImage = 65.w;

    return Container(
      width: width * 0.85,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10, top: 10),
      child: Column(
        children: [
          SquareHorizontalItem(
            sizeImage: Size(sizeImage, 50.h),
            image: song.thumb ?? '',
            title: song.title ?? '',
            subTitle: song.channel,
            hidenBg: true,
            // subMenu: OptionMenu(
            //   song: song,
            // ),
            onTap: () {
              // BlocProvider.of<ProPlayerCubit>(context).open(song: song,songs: songs);
            },
          ),
        ],
      ),
    );
  }
}
