import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'components/profile_info_item_widget.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Add Your Code here.
  //     BlocProvider.of<ArtistCubit>(context).getFollowers();
  //   });
  // }

  // List<ArtistModel> listFollowingArtists = [];

  @override
  Widget build(BuildContext context) {
    // List<PlaylistModel> playlists = <PlaylistModel>[];
    final sizeImg = ScreenUtil().setWidth(90);
    // return BlocBuilder<PlaylistCubit, PlaylistState>(
    //     buildWhen: (_, state) => state is PlaylistListUpdate,
    //     builder: (_, state) {
    //       if (state is PlaylistListUpdate) {
    //         // playlists = state.playlists;

    //         if (state.playlists.isNotEmpty) {
    //           for (final item in state.playlists) {
    //             if (item.title == Const.nameFavourite ||
    //                 item.title == Const.nameLibrary) {
    //               continue;
    //             }
    //             playlists.add(item);
    //           }
    //         }
    //       }
    //       return BlocBuilder<AuthCubit, AuthState>(
    //         builder: (_, state) {
    //           UserModel _user;

    //           if (state is AutheAuthenticated) {
    //             _user = state.user;
    //           }
              return SafeArea(
                top: false,
                bottom: false,
                child: Scaffold(
                  appBar: AppBar(
                    leading: IconButton(
                      onPressed: ()=>Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppStyles.grey3,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // BlocProvider.of<AuthCubit>(context).logout();
                        },
                        child: Text(
                          'Logout',
                          style: AppStyles.copyStyle(
                            color: Const.colorPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  body: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            ScreenUtil().setWidth(Const.paddingHorizon)),
                    child: Column(
                      // padding:
                      //     const EdgeInsets.symmetric(horizontal: Const.padding_horizon),
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [],
                        // ),
                        SizedBox(
                            height:
                                Const.paddingHorizon.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(sizeImg.w / 2),
                          child: Container(
                            width: sizeImg.w,
                            height: sizeImg.w,
                            color: Colors.red,
                            child: 
                            // _user?.avatar != null
                            //     ? CachedNetworkImage(
                            //         imageUrl: _user.avatar,
                            //         fit: BoxFit.cover,
                            //       )
                            //     : 
                                const SizedBox(),
                          ),
                        ),
                        SizedBox(
                            height: Const.paddingHorizon.h * 2),
                        Text(
                          // _user?.name ?? 
                          '',
                          style: AppStyles.title(context,
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                            height: Const.paddingHorizon.h * 2),
                        // BlocBuilder<ArtistCubit, ArtistState>(
                        //   buildWhen: (_, state) => state is ArtistListState,
                        //   builder: (context, state) {
                        //     if (state is ArtistListState) {
                        //       listFollowingArtists = state.artists;
                        //     }
                            // return 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProfileInfoItemWidget(
                                    onTab: () {},
                                    title: 
                                    // playlists.length > 1
                                    //     ? 'PLAYLISTS'
                                    //     :
                                         'PLAYLIST',
                                    number: 0
                                    // playlists.length,
                                    ),
                                ProfileInfoItemWidget(
                                  onTab: () {
                                    // Utils.navigatePage(
                                    //     context,
                                    //     FollowingArtistView(
                                    //       artitsts: listFollowingArtists,
                                    //     ));
                                  },
                                  title: 
                                  // listFollowingArtists.length > 1
                                  //     ? 'FOLLOWING ARTISTS'
                                  //     : 
                                      'FOLLOWING ARTIST',
                                  number: 0
                                  // listFollowingArtists.length,
                                ),
                              ],
                            ),
                        //   },
                        // ),
                        SizedBox(
                            height: Const.paddingHorizon.h * 3),
                        // HeaderView(
                        //   title: playlists.length > 1
                        //       ? 'Your Playlists'
                        //       : 'Your Playlist',
                        // ),
                        SizedBox(
                            height: Const.paddingHorizon.h * 2),
                        // Column(
                        //     children: List.generate(
                        //   playlists.length,
                        //   (index) {
                        //     final playlist = playlists[index];

                        //     if (playlist.title == Const.name_favourite ||
                        //         playlist.title == Const.name_library) {
                        //       return const SizedBox.shrink();
                        //     }
                        //     return Padding(
                        //       padding: EdgeInsets.only(
                        //           left: ScreenUtil()
                        //               .setHeight(Const.padding_horizon),
                        //           right: ScreenUtil()
                        //               .setHeight(Const.padding_horizon),
                        //           top: ScreenUtil()
                        //               .setHeight(Const.padding_horizon)),
                        //       child: SquareHorizontalItem(
                        //         sizeImage: Size(sizeImg, sizeImg),
                        //         title: playlist?.title ?? '',
                        //         image: playlist?.thumb ?? MyIcons.ic_music,
                        //         colorBgImage: Const.color_bgIcon1,
                        //         subTitle: '${playlist?.videoCount} songs' ?? '',
                        //         subMenu: OptionMenu(
                        //           playlist: playlist,
                        //         ),
                        //         onTap: () {
                        //           Utils.navigatePage(
                        //             context,
                        //             PlaylistDetailView(
                        //               playlist: playlist,
                        //             ),
                        //           );
                        //         },
                        //       ),
                        //     );
                        //   },
                        // )),
                      ],
                    ),
                  ),
                ),
              );
        //     },
        //   );
        // });
  }
}
