import 'package:base_project/components/shimmer/items/square_horizontal_item.dart';
import 'package:base_project/components/shimmer/square_horizontal_shimmer.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/helper/utils.dart';
import 'package:base_project/models/song_model.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'trending_detail_view.dart';

class TrendingView extends StatefulWidget {
  const TrendingView({Key? key}) : super(key: key);

  @override
  State<TrendingView> createState() => _TrendingViewState();
}

class _TrendingViewState extends State<TrendingView>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  // List<SongModel> songs = [];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AppCubit, AppState>(
    //   buildWhen: (prev, state) {
    //     return state is AppTrendingChangeState;
    //   },
    //   builder: (_, state) {
    //     RegionModel _region = RegionModel(code: 'us', name: 'United States');
    //     int length;
    //     debugPrint('$state');
    //     if (state is AppTrendingChangeState) {
    //       _region = state.region;
    //       length = _region.code == 'US' ? 1 : 2;
    //     }
    return FutureBuilder(
        future: _fakeDataUs(),
        builder: (_, snapshot) {
          List<SongModel> songs = [];
          final isWaiting = snapshot.connectionState == ConnectionState.waiting;
          if (snapshot.data != null) {
            songs = snapshot.data as List<SongModel>;
          }
          return Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                height: 475.h,
                child: Column(
                  children: [
                    Container(
                      height: ScreenUtil().setHeight(42),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: TabBar(
                        labelStyle: AppStyles.title(
                          context,
                        ),
                        controller: _tabController,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              25.0,
                            ),
                            gradient: AppStyles.gradient),
                        labelColor: Colors.white,
                        unselectedLabelColor: AppStyles.grey3,
                        tabs: [
                          Tab(text: 'globalTrending'.tr()
                              // LocaleKeys.globalTrending.tr(),
                              ),
                          const Tab(text: 'Việt Nam'),
                        ],
                      ),
                    ),
                    // tab bar view here
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: ScreenUtil().setHeight(20)),
                        decoration: BoxDecoration(
                            gradient: AppStyles.gradient,
                            borderRadius: BorderRadius.circular(10)),
                        child: TabBarView(
                          controller: _tabController,
                          children: List.generate(
                            2,
                            (index) {
                              return Column(
                                children: [
                                  _buildListVideo(songs, isWaiting),
                                  SizedBox(height: 8.h),
                                  Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          Utils.navigatePage(
                                            context,
                                            TrendingDetailView(
                                                countryCode: '',
                                                songs: songs,
                                                background: index == 0
                                                    ? AppIcons.bgTrending2
                                                    : AppIcons.bgTrending1,
                                                name: index == 0
                                                    ? 'Global'
                                                    : 'Việt Nam'),
                                          );

                                          // Utils.navigatePage(
                                          //   context,
                                          //   TrendingDetailView(
                                          //       countryCode: index == 0
                                          //           ? 'US'
                                          //           : _region.code,
                                          //       background: index == 0
                                          //           ? MyIcons.bg_trending2
                                          //           : MyIcons.bg_trending1,
                                          //       name: index == 0
                                          //           ? 'Global'
                                          //           : _region.name),
                                          // );
                                        },
                                        child: Text(
                                          'seeMore'.tr(),
                                          // LocaleKeys.seeMore.tr(),
                                          style: AppStyles.copyStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        )),
                                  ),
                                  // const SizedBox(height: 5),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
    // return const SizedBox.shrink();
    //   },
    // );
  }

  Future _fakeDataUs() async {
    await Future.delayed(const Duration(milliseconds: 400));

    return List.generate(
      10,
      (index) => SongModel(
          thumb: 'http://img.youtube.com/vi/qpgTC9MDx1o/default.jpg',
          title: 'Maroon 5 - Animals (Official Music Video)',
          channel: 'Maroon 5'),
    );
  }

  Widget _buildListVideo(List<SongModel> songs, bool isWaiting) {
    final sizeImage = ScreenUtil().setWidth(65);
    return Container(
      height: 355.h,
      width: double.infinity,
      padding: EdgeInsets.only(top: Const.paddingHorizon.w),
      child: songs.isNotEmpty
          ? CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(
                      songs.length > 5 ? 5 : songs.length,
                      (index) {
                        if (isWaiting) {
                          return Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(10),
                                  right: ScreenUtil().setWidth(10),
                                  bottom: ScreenUtil().setHeight(20)),
                              child: SquareHorizontalShimmer(
                                hasSubText: true,
                                sizeImage: Size(
                                  sizeImage,
                                  ScreenUtil().setHeight(50),
                                ),
                              ));
                        }

                        final song = songs[index];
                        final widgetItem = Container(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(10)),
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              SquareHorizontalItem(
                                sizeImage:
                                    Size(sizeImage, ScreenUtil().setHeight(50)),
                                image: song.thumb ?? '',
                                title: song.title ?? '',
                                subTitle: song.channel,
                                hidenBg: true,
                                colorTitle: Colors.white,
                                isColorTrending: true,
                                onTap: () {
                                  // BlocProvider.of<ProPlayerCubit>(context)
                                  //     .open(song: song,songs: songs);
                                },
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: 75.w, top: 10.h),
                                  height: 0.2,
                                  color: Colors.white)
                            ],
                          ),
                        );
                        return widgetItem;
                      },
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
