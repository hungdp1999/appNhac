import 'package:base_project/components/appbar_back_button.dart';
import 'package:base_project/components/shimmer/items/square_horizontal_item.dart';
import 'package:base_project/components/shimmer/square_horizontal_shimmer.dart';
import 'package:base_project/models/song_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingDetailView extends StatelessWidget {
  final String? countryCode;
  final String? background;
  final String? name;
  final List<SongModel>? songs;

  const TrendingDetailView({
    super.key,
    @required this.countryCode,
    @required this.background,
    @required this.name,
    @required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    // return StreamBuilder(
    //     stream: InappPurchaseService.instance.stateInappStream.stream,
    //     builder: (_, infoInapp) {
    // return StreamBuilder(
    //   stream: Stream.fromFuture(
    //     _fakeData(),
    //   ),
    //   builder: (_, snapshot) {
    //     List<SongModel> songs = [];
    //     final isWaiting =
    //         snapshot.connectionState == ConnectionState.waiting;

    //     if (snapshot.data != null) {
    //       songs = snapshot.data as List<SongModel>;
    //     }

    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          title: AppBarBackButton(
            title: name,
            onTap: () => Navigator.pop(context),
          ),
          centerTitle: false,
        ),
        body: SizedBox(
          width: double.infinity,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      children: [
                        // ItemTrending(
                        //   width: ScreenUtil().setWidth(220),
                        //   height: ScreenUtil().setWidth(220),
                        //   background: background,
                        //   name: name,
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //     vertical: ScreenUtil().setHeight(18),
                        //   ),
                        //   child: Text(
                        //     name ?? '',
                        //     style: MyStyles.copyStyle(
                        //       fontSize: 24,
                        //       fontWeight: FontWeight.w700,
                        //     ),
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //   ),
                        // ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          // child: PlayShuffleButton(
                          //   onPlay: () {},
                          //   onShuffle: () {},
                          //   // onAddSong: enableAddSong ? () {} : null,
                          // ),
                        ),
                        const SizedBox(height: 10)
                      ],
                    )
                  ],
                ),
              ),
              // if (!InappPurchaseService.instance.isVip)
              //   SliverPersistentHeader(
              //     pinned: true,
              //     delegate: CustomSliverDelegate(
              //       backgroundColor: color,
              //       context: context,
              //       minHeight: 55.0,
              //       maxHeight: 55.0,
              //       child: Container(
              //         constraints: BoxConstraints(
              //           minHeight: ScreenUtil().setHeight(55),
              //           maxHeight: ScreenUtil().setHeight(55),
              //         ),
              //         width: double.infinity,
              //         padding: EdgeInsets.only(
              //           left: Utils.paddingAds(
              //               MediaQuery.of(context).size.width),
              //         ),
              //         child: const BannerAdWidget(),
              //       ),
              //     ),
              //   ),
              SliverList(
                delegate: SliverChildListDelegate(
                  List.generate(
                    songs!.length,
                    (index) {
                      final sizeImage = ScreenUtil().setWidth(65);
                      final sizeImageHeight = ScreenUtil().setHeight(50);

                      // if (isWaiting) {
                      //   return Padding(
                      //     padding: EdgeInsets.only(
                      //         bottom: ScreenUtil().setHeight(10)),
                      //     child: SquareHorizontalShimmer(
                      //       sizeImage:
                      //           Size(sizeImage, sizeImageHeight),
                      //       hasSubText: true,
                      //     ),
                      //   );
                      // }
                      // if (index == songs.length) {
                      //   return const BottomPaddingPlaying();
                      // }
                      final song = songs![index];
                      final widgetItem = Container(
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
                              // subMenu: OptionMenu(
                              //   song: song,
                              // ),
                              onTap: () {
                                // BlocProvider.of<ProPlayerCubit>(
                                //         context)
                                //     .open(song: song, songs: songs);
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(75), top: 10),
                                height: 0.2,
                                color: Colors.white)
                          ],
                        ),
                      );
                      // if (Utils.isShowAdAtIndex(index) &&
                      //     !InappPurchaseService.instance.isVip) {
                      //   return Column(
                      //     crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(
                      //             bottom: ScreenUtil().setHeight(10)),
                      //         child: const NativeAdWidget(),
                      //       ),
                      //       widgetItem,
                      //     ],
                      //   );
                      // }

                      return widgetItem;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //   },
    // );
    // });
  }
}
