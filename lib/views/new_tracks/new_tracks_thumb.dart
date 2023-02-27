import 'package:flutter/material.dart';

import 'package:base_project/components/header_more.dart';
import 'package:base_project/components/list_item_4x3_view.dart';
import 'package:base_project/components/shimmer/square_horizontal_shimmer.dart';
import 'package:base_project/models/song_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewTrackThumb extends StatelessWidget {
  const NewTrackThumb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<AppCubit>(context).getDefaultRegion();
    // return BlocBuilder<AppCubit, AppState>(buildWhen: (prev, state) {
    //   return state is AppTrendingChangeState;
    // }, builder: (context, state) {
    //   RegionModel _region;

    //   if (state is AppTrendingChangeState) {
    //     _region = state.region;
    //   }
    return FutureBuilder(
      // future:  _fetchTopNewTracks(_region?.code ?? 'US'),
      future: _fakeData(),
      builder: (_, snapshot) {
        var songs = <SongModel>[];
        var body = <Widget>[];
        final isWaiting = snapshot.connectionState == ConnectionState.waiting;

        if (isWaiting) {
          body = List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.only(left: 10, top: 5),
              child: SquareHorizontalShimmer(
                sizeImage: Size(60.h, 40.w),
              ),
            ),
          );
        }
        if (snapshot.data != null) {
          songs = snapshot.data as List<SongModel>;
          body = const [SizedBox.shrink()];

          if (songs.isNotEmpty) body = [ListItem4x3View(songs: songs)];
        }

        // create function
        void onSeeMore() {
          if (songs.isNotEmpty) {
            // Utils.navigatePage(
            //   context,
            //   TrackList(
            //     songs: snapshot.data as List<SongModel>,
            //     title: LocaleKeys.topNewTracks.tr(),
            //   ),
            // );
          }
        }

        return Column(
          children: [
            HeaderMore(
              title: 'topNewTracks'.tr(),
              onSeeMore: onSeeMore,
            ),
            ...body
          ],
        );
      },
    );
    // });
  }

  // Future _fetchTopNewTracks(String countryCode) async {
  //   try {
  //     final res = await ApiClient.instance.getTopNewTracks(countryCode);
  //     final response = RecommendResponse.fromJson(res);
  //     return response.musics;
  //   } catch (e) {
  //     return [];
  //   }
  // }
  Future _fakeData() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      9,
      (index) => SongModel(
          thumb: 'https://img.youtube.com/vi/W4P8gl4dnrg/maxresdefault.jpg',
          title: 'Hẹn Ước Từ Hư Vô',
          channel: 'My Tam'),
    );
  }
}
