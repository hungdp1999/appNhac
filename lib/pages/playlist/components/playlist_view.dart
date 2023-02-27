import 'package:base_project/components/shimmer/items/square_horizontal_item.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PlaylistView extends StatelessWidget {
  const PlaylistView({Key? key}) : super(key: key);

//   @override
//   State<PlaylistView> createState() => _PlaylistViewState();
// }

// class _PlaylistViewState extends State<PlaylistView>
//     with AutomaticKeepAliveClientMixin {
//   List<PlaylistModel> playlists = [];
//   // PlaylistModel favouritePlaylist;
//   // PlaylistCubit _playlistCubit;

//   @override
//   void initState() {
//     debugPrint('PlaylistListUpdate PlaylistView');
//     // _playlistCubit = BlocProvider.of<PlaylistCubit>(context);
//     // getAllPlaylist();
//     // _playlistCubit.listen((state) {
//     //   if (state is PlaylistListUpdate) {
//     //     getAllPlaylist();
//     //   }
//     // });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    List<PlaylistModel> playlists = [];
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final sizeWidthImg = ScreenUtil().setWidth(70);
    final sizeHeightImg = ScreenUtil().setHeight(60);
    return GestureDetector(
      onTap: () {
        // Utils.dismissKeyboard(context);
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(15),
        ),
        child: Column(
          children: [
            // if (favouritePlaylist != null && favouritePlaylist.videoCount > 0)
            //   buildSlidable(
            //     favouritePlaylist: favouritePlaylist,
            //     child: Padding(
            //       padding: EdgeInsets.only(
            //         bottom: 10.h,
            //       ),
            //       child: SquareHorizontalItem(
            //         sizeImage: Size(sizeWidthImg, sizeHeightImg),
            //         title: 'favoriteSong'.tr(),
            //         // title: favouritePlaylist.title ?? '',
            //         subTitle: '',
            //             // '${favouritePlaylist?.videoCount} ${LocaleKeys.track.tr()}' ??
            //             //     '0 ${LocaleKeys.track.tr()}',
            //         image: AppIcons.icHeart0,
            //         // favouritePlaylist?.thumb ?? MyIcons.ic_heart0,
            //         colorBgImage: AppStyles.grey3,
            //         onTap: () {
            //           // Utils.navigatePage(
            //           //   context,
            //           //   FavouriteDetail(
            //           //     playlist: favouritePlaylist,
            //           //   ),
            //           // );
            //         },
            //       ),
            //     ),
            //   ),

            Column(
              children: List.generate(
                playlists.length,
                (index) {
                  final playlist = playlists[index];

                  if (playlist.title == Const.nameFavourite ||
                      playlist.title == Const.nameLibrary) {
                    return const SizedBox.shrink();
                  }
                  return buildSlidable(context,
                      playlist: playlist,
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: ScreenUtil().setHeight(10),
                        ),
                        child: SquareHorizontalItem(
                          sizeImage: Size(sizeWidthImg, sizeHeightImg),
                          title: playlist.title ?? '',
                          image: playlist.thumb ?? AppIcons.icDefaultThumb,
                          colorBgImage: bgColor,
                          subTitle: '${playlist.videoCount} ${'track'.tr()}',
                          // subMenu: OptionMenu(
                          //   playlist: playlist,
                          // ),
                          onTap: () {
                            // Utils.navigatePage(
                            //   context,
                            //   PlaylistDetailView(
                            //     playlist: playlist,
                            //   ),
                            // );
                          },
                        ),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSlidable(BuildContext context,
      {PlaylistModel? favouritePlaylist,
      Widget? child,
      PlaylistModel? playlist}) {
    // final isFavorite = playlists?.title == Const.favorite;
    // final bgColor = Theme.of(context).scaffoldBackgroundColor;
    // final darkModeOn = bgColor == AppStyles.grey;
    return Slidable(
      // actionPane: const SlidableDrawerActionPane(),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children:
            // favouritePlaylist != null
            //   ?  [
            //       SlidableAction(
            //         color: darkModeOn ? MyStyles.grey1 : MyStyles.grey5,
            //         icon: Image.asset(
            //           MyIcons.icShare,
            //           width: 24,
            //           color: darkModeOn ? MyStyles.grey3 : null,
            //         ),
            //       ),
            //       // IconSlideAction(
            //       //   color: darkModeOn ? MyStyles.grey1 : MyStyles.grey5,
            //       //   iconWidget: Image.asset(
            //       //     MyIcons.iDeletePlaylist,
            //       //     width: 24,
            //       //     color: darkModeOn ? MyStyles.grey3 : null,
            //       //   ),
            //       //   onTap: () => BlocProvider.of<PlaylistCubit>(context)
            //       //       .deletePlaylist(playlist.playlistId),
            //       // ),
            //     ]
            //   :
            [
          SlidableAction(
            backgroundColor: AppStyles.grey5,
            icon: Icons.share,
            //  Image.asset(
            //   MyIcons.icShare,
            //   width: 24,
            //   color: darkModeOn ? MyStyles.grey3 : null,
            // ),
            onPressed: doNothing,
            // onTap: () => navigator(),
          ),
          SlidableAction(
            backgroundColor: AppStyles.grey5,
            icon: Icons.edit,
            // Image.asset(
            //   MyIcons.iEditPlaylist,
            //   width: 24,
            //   color: darkModeOn ? MyStyles.grey3 : null,
            // ),
            onPressed: doNothing,
            // () => _handleEditPlaylist(context, playlist),
          ),
          SlidableAction(
            backgroundColor: AppStyles.grey5,
            icon: Icons.delete,
            // iconWidget: Image.asset(
            //   MyIcons.iDeletePlaylist,
            //   width: 24,
            //   color: darkModeOn ? MyStyles.grey3 : null,
            // ),
            onPressed: doNothing,
            // onTap: () => _handleDeletePlayList(playlist),
          ),
        ],
      ),

      child: child!,
    );
  }

  // Future _handleEditPlaylist(
  //     BuildContext context, PlaylistModel playlist) async {
  //   showDialog(
  //       context: context,
  //       builder: (_) {
  //         return Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: ScreenUtil().setWidth(Const.padding_horizon * 2),
  //           ),
  //           child: PlaylistDialog(
  //             title: 'Rename playlist',
  //             hintText: 'Enter the name of the playlist',
  //             initText: playlist.title,
  //             titleButton: 'Submit',
  //             onSubmit: (text) {
  //               BlocProvider.of<PlaylistCubit>(context).editPlaylistName(
  //                 playlist.playlistId,
  //                 title: text,
  //               );
  //             },
  //           ),
  //         );
  //       });
  // }

  // void _handleDeletePlayList(PlaylistModel playlist) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //         child: CommonDialog(
  //           onTap: () {
  //             BlocProvider.of<PlaylistCubit>(context)
  //                 .deletePlaylist(playlist.playlistId);
  //             Navigator.of(context).pop();
  //           },
  //           title: LocaleKeys.dialogDeletePlaylistTitle.tr(),
  //           buttonTitle: LocaleKeys.dialogDeletePlaylistButton.tr(),
  //           content: LocaleKeys.dialogDeletePlaylistContent
  //               .tr(args: [playlist.title]),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future getAllPlaylist() async {
  //   final playlists2 = await AppDatabase.instance.getAllPlaylist();
  //   setState(() {
  //     playlists = playlists2;
  //     if (playlists.isNotEmpty) {
  //       for (final item in playlists) {
  //         if (item.title == Const.name_favourite) {
  //           favouritePlaylist = item;
  //           break;
  //         }
  //       }
  //     }
  //   });
  // }

  void doNothing(BuildContext context) {}

  // @override
  // bool get wantKeepAlive => true;
}
