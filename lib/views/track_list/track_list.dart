import 'package:base_project/components/appbar_back_button.dart';
import 'package:base_project/components/play_shuffle_button.dart';
import 'package:base_project/components/shimmer/items/square_horizontal_item.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/models/song_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackList extends StatelessWidget {
  final String? title;
  final List<SongModel>? songs;

  const TrackList({super.key, 
    this.title,
    this.songs,
  });

  @override
  Widget build(BuildContext context) {
    final sizeImage = 65.w;
    final sizeImageHeight = 50.h;
    final color = Theme.of(context).scaffoldBackgroundColor;
    // return StreamBuilder(
    //   stream: InappPurchaseService.instance.stateInappStream.stream,
    //   builder: (_, infoInapp) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Scaffold(
            // backgroundColor: MyStyles.grey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: color,
              leadingWidth: 0,
              leading: const SizedBox.shrink(),
              title: AppBarBackButton(
                title: title ?? '',
                onTap: () => Navigator.pop(context),
              ),
              centerTitle: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(
                    // !InappPurchaseService.instance.isVip
                    //     ? ScreenUtil().setHeight(130)
                    //     :
                         ScreenUtil().setHeight(60)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(Const.paddingHorizon.w),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: PlayShuffleButton(
                            onShuffle: () {
                              // BlocProvider.of<ProPlayerCubit>(context)
                              //     .open(songs: songs, isShuffle: true
                                      // isShuffle: true,
                                      // );
                            },
                            onPlay: () {
                              // BlocProvider.of<ProPlayerCubit>(context)
                              //     .open(songs: songs, noShuffle: true);
                            },
                          )),
                      // if (!InappPurchaseService.instance.isVip)
                      //   Container(
                      //     color: Colors.transparent,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           bottom: ScreenUtil().setHeight(10)),
                      //       child: const BannerAdWidget(),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(Const.paddingHorizon.w)),
              child: ListView.builder(
                // padding: EdgeInsets.symmetric(
                //   horizontal: ScreenUtil().setWidth(Const.padding_horizon),
                // ),
                itemCount: songs?.length,
                itemBuilder: (_, index) {
                  final song = songs![index];
                  final widgetIten = Container(
                    padding:
                        EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SquareHorizontalItem(
                          sizeImage: Size(sizeImage, sizeImageHeight),
                          image: song.thumb ?? '',
                          title: song.title ?? '',
                          subTitle: song.channel,
                          hidenBg: true,
                          // subMenu: OptionMenu(song: song),
                          onTap: () {
                            // BlocProvider.of<ProPlayerCubit>(context)
                            //     .open(song: song, songs: songs);
                          },
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: 75.w, top: 10.h),
                            height: 0.2,
                            color: Colors.white)
                      ],
                    ),
                  );
                  // if (index == songs?.length) {
                  //   return const BottomPaddingPlaying();
                  // }
                  // if (Utils.isShowAdAtIndex(index) &&
                  //     !InappPurchaseService.instance.isVip) {
                  //   return Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       const NativeAdWidget(),
                  //       const SizedBox(
                  //         height: 10,
                  //       ),
                  //       widgetIten,
                  //     ],
                  //   );
                  // }

                  return widgetIten;
                },
              ),
            ),
          ),
        );
      // },
    // );
  }
}
