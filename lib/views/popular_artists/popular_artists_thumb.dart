import 'package:flutter/material.dart';

import 'package:base_project/components/shimmer/square_vertical_shimmer.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/models/artist_model.dart';
import 'package:base_project/styles/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopularArtistsThumb extends StatelessWidget {
  const PopularArtistsThumb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<AppCubit, AppState>(
    //   buildWhen: (prev, state) {
    //     return state is AppTrendingChangeState;
    //   },
    //   builder: (_, state) {
    //     //change region
    //     RegionModel _region;

    //     if (state is AppTrendingChangeState) {
    //       _region = state.region;
    //     }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: Const.paddingHorizon,
            top: Const.paddingHorizon,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: FutureBuilder(
            future: _fakeData(),
            builder: (context, snapshot) {
              var artists = <ArtistModel>[];
              var length = 5;
              final isWaiting =
                  snapshot.connectionState == ConnectionState.waiting;

              if (snapshot.data != null) {
                artists = snapshot.data as List<ArtistModel>;
                length = artists.length > 8 ? 8 : artists.length;
              }

              // create function
              void seeMore() {
                // Utils.navigatePage(
                //     context,
                //     PopularArtistsView(
                //       artists: artists,
                //       region: _region,
                //     ));
              }

              return Row(
                children: List.generate(
                  length + 1,
                  (index) {
                    if (isWaiting) {
                      return Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SquareVerticalShimmer(
                          sizeImage: Size(100.w, 100.w),
                        ),
                      );
                    }
                    if (length == index) return _SeeMoreButton(onTap: seeMore);

                    final artist = artists[index];
                    return _ArtistWidget(artist: artist);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
    //   },
    // );
  }

  Future _fakeData() async {
    await Future.delayed(const Duration(seconds: 1));

    return List.generate(
        9,
        (index) => ArtistModel(
            imgPath:
                'https://kenh14cdn.com/thumb_w/620/2020/7/17/brvn-15950048783381206275371.jpg',
            name: 'hieunh.195'));
  }
}

class _ArtistWidget extends StatelessWidget {
  const _ArtistWidget({
    Key? key,
    required this.artist,
  }) : super(key: key);

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) {
    final size = 100.w;
    return InkWell(
      onTap: () {
        // Utils.navigatePage(context,
        //     ArtistDetailView(artistModel: artists[index]));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10.w),
        width: size,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: CachedNetworkImage(
                imageUrl: artist.imgPath ?? '',
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorWidget: (_, url, __) {
                  return Image.asset(
                    url,
                    width: size,
                    height: size,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                artist.name ?? '',
                style: AppStyles.title(
                  context,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SeeMoreButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SeeMoreButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = 40.w;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15.w, bottom: 25.h),
        decoration: const BoxDecoration(
            color: AppStyles.mainColor, shape: BoxShape.circle),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 20.h,
          color: AppStyles.white,
        ),
      ),
    );
  }
}
