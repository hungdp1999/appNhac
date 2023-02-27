import 'dart:async';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_project/helper/custom_sliver_delegate.dart';
import 'package:base_project/helper/sliver_header_delegate.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/new_tracks/new_tracks_thumb.dart';
import 'package:base_project/views/popular_artists/popular_artists_thumb.dart';
import 'package:base_project/views/top_tracks/top_tracks_thumb.dart';
import 'components/item_bg_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _customController = ScrollController();
  final _bgSearchController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _customController.addListener(
        (() => _bgSearchController.sink.add(_customController.offset)));

    // InappPurchaseService.instance.stateInappStream.stream.listen((event) {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _customController.dispose();
    _bgSearchController.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height / 2;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: ItemBgSearchView(
                stream: _bgSearchController.stream,
              ),
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _customController,
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 100.h,
                    maxHeight: 100.h,
                    child: StreamBuilder(
                      stream: _bgSearchController.stream,
                      builder: (context, snapshot) {
                        var bgColor = Colors.transparent;
                        final offset = snapshot.data ?? 0.0;

                        if (offset > 50.0) bgColor = scaffoldColor;

                        return Container(
                          color: bgColor,
                          padding: EdgeInsets.only(
                              top: 50.h, left: 15, right: 15, bottom: 10),
                          child: const _ItemSearch(),
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.transparent,
                    height: size,
                    alignment: Alignment.bottomCenter,
                    child: const PopularArtistsThumb(),
                  ),
                ),

                // if (!InappPurchaseService.instance.isVip)
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CustomSliverDelegate(
                    backgroundColor: scaffoldColor,
                    context: context,
                    minHeight: 60,
                    maxHeight: 60,
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: 60,
                        maxHeight: 60,
                      ),
                      color: scaffoldColor,
                      width: double.infinity,
                      // padding: EdgeInsets.only(
                      //   left: Utils.paddingAds(MediaQuery.of(context).size.width),
                      // ),
                      // child: const BannerAdWidget(),
                      child: const TestAdsWidget(),
                    ),
                  ),
                ),

                _ItemTopic(
                  title: 'nowStreaming'.tr(),
                  onTap: () {
                    // Utils.navigatePage(
                    //     context,
                    //     NowStreamingDetail(
                    //       title: LocaleKeys.nowStreaming.tr(),
                    //     ));
                  },
                ),
                _ItemTopic(
                  title: 'searchTopic'.tr(),
                  onTap: () {
                    //  Utils.navigatePage(
                    //   context,
                    //   const TopicCategoryView(
                    //       // categories: categories,
                    //       )),
                  },
                ),
                _ItemTopic(
                  title: 'tplay'.tr(),
                  // onTap:() => Utils.navigatePage(context, PopularPlaylistView())
                ),

                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TopTracksThumb(),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: NewTrackThumb(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ItemTopic extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _ItemTopic({Key? key, required this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppStyles.grey7, width: .5),
          ),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          title: Text(
            title,
            style: AppStyles.title(
              context,
              fontWeight: FontWeight.w800,
              fontSize: 18.sp,
            ),
          ),
          trailing:
              const Icon(Icons.keyboard_arrow_right, color: AppStyles.grey3),
        ),
      ),
    );
  }
}

class TestAdsWidget extends StatelessWidget {
  const TestAdsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      child: Text(
        'Test Ads',
        style: TextStyle(color: Colors.black, fontSize: 16.sp),
      ),
    );
  }
}

class _ItemSearch extends StatelessWidget {
  const _ItemSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () =>
      //     Utils.navigatePage(context, const SearchView()),
      child: Container(
        height: 40.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppStyles.grey4,
          border: Border.all(width: 1, color: AppStyles.grey4),
          borderRadius: BorderRadius.circular(32.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                'searchHintTextField'.tr(),
                style: AppStyles.copyStyle(
                  fontSize: 16.sp,
                  color: AppStyles.grey2,
                ),
              ),
            ),
            Image.asset(AppIcons.iSearch, width: 24.w, height: 24.h)
          ],
        ),
      ),
    );
  }
}
