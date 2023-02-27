import 'dart:async';

import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/top_tracks/top_tracks_4x3.dart';
import 'package:base_project/views/trending/trending_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  // List<CategoryModel> categories = [];
  final ScrollController _scrollController = ScrollController();

  // ignore: close_sinks
  final StreamController _streamController = StreamController.broadcast();
  // AppCubit _appCubit;
  // bool _darkMode = false;

  @override
  void initState() {
    // InappPurchaseService.instance.stateInappStream.stream.listen((event) {
    //   setState(() {});
    // });
    _scrollController.addListener(() {
      _streamController.sink.add(_scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).scaffoldBackgroundColor;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color,
          centerTitle: false,
          title: Text(
            'trendingHeader'.tr(),
            style: AppStyles.copyStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppStyles.mainColor),
          ),
        ),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const TrendingView(),
                  SizedBox(height: 15.h)
                  // TopTracks4x3(),
                ],
              ),
            ),
            // if (!InappPurchaseService.instance.isVip)
            //   SliverPersistentHeader(
            //     pinned: true,
            //     delegate: CustomSliverDelegate(
            //       context: context,
            //       backgroundColor: Colors.transparent,
            //       minHeight: 60,
            //       maxHeight: 60,
            //       isShowBackgroundImmediately: true,
            //       child: Container(
            //         constraints: const BoxConstraints(
            //           minHeight: 60,
            //           maxHeight: 60,
            //         ),
            //         // padding: EdgeInsets.only(
            //         //   left: Utils.paddingAds(
            //         //       MediaQuery.of(context).size.width),
            //         // ),
            //         child: const BannerAdWidget(),
            //       ),
            //     ),
            //   ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const TopTracks4x3(),
                  // const BottomPaddingPlaying(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
