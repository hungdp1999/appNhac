import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaylistAppBar extends StatelessWidget {
  const PlaylistAppBar({
    Key? key,
    this.tabController,
    this.playlists,
    // this.favouritePlaylist,
  }) : super(key: key);
  final TabController? tabController;
  final List<PlaylistModel>? playlists;
  // final PlaylistModel? favouritePlaylist;

//   @override
//   State<PlaylistAppBar> createState() => _PlaylistAppBarState();
// //
// // @override
// // Size get preferredSize => Size.fromHeight(
// //     ScreenUtil().setHeight(170 + 58 + 18 + 10 + 188 + 30 + 60));
// }

// class _PlaylistAppBarState extends State<PlaylistAppBar> {
//   int indexSelected = 0;

//   @override
//   void initState() {
//     widget.tabController!.addListener(() {
//       indexSelected = widget.tabController!.index;
//       setState(() {});
//     });

//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          // Padding(
          //   padding: EdgeInsets.only(
          //     // left: ScreenUtil().setWidth(Const.padding_horizon),
          //     // right: ScreenUtil().setWidth(Const.padding_horizon),
          //     top: ScreenUtil().setHeight(13),
          //   ),
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Align(
          //         alignment: Alignment.centerLeft,
          //         child: Padding(
          //           padding: EdgeInsets.symmetric(
          //               horizontal: ScreenUtil().setWidth(Const.padding_horizon),
          //               vertical: 20),
          //           child: Text(
          //             'PLAYLIST',
          //             style: MyStyles.copyStyle(
          //                 fontSize: 24,
          //                 fontWeight: FontWeight.w700,
          //                 color: MyStyles.mainColor),
          //           ),
          //         ),
          //       ),
          //       const RecentlyPlayed(),
          //       Padding(
          //         padding: EdgeInsets.symmetric(
          //           horizontal: ScreenUtil().setWidth(Const.padding_horizon),
          //         ),
          //         child:
          Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 85.h,
            child: Row(
              children: [
                _tab(context ,'homeMyPlaylist'.tr(), 0),
                _tab(context,'library'.tr(), 1),
                SizedBox(
                  width: 50.w,
                ),
                if (playlists!.length > 2 
                // ||
                    // widget.favouritePlaylist?.videoCount > 0
                    )
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.import_contacts,
                  //     color: MyStyles.mainColor,
                  //     size: 24,
                  //   ),
                  GestureDetector(
                    onTap: () async {
                      // final type = await DialogHelper.instance
                      //     .showImportOptionPlaylistDialog(context);
                      // if (type == 0) {
                      //   DialogHelper.instance
                      //       .showImportPlaylistDialog(context, 0);
                      // } else if (type == 1) {
                      //   DialogHelper.instance
                      //       .showImportPlaylistDialog(context, 1);
                      // }
                    },
                    child: Image.asset(
                      AppIcons.iImportPlaylist,
                      color: AppStyles.mainColor,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                // onPressed: () async {
                //   final type = await DialogHelper.instance
                //       .showImportOptionPlaylistDialog(context);
                //   if (type == 0) {
                //     DialogHelper.instance
                //         .showImportPlaylistDialog(context, 0);
                //   } else if (type == 1) {
                //     DialogHelper.instance
                //         .showImportPlaylistDialog(context, 1);
                //   }
                // },
                // ),
                // if (widget.playlists!.length > 2
                //  ||
                //     widget.favouritePlaylist.videoCount > 0
                //     )
                //   IconButton(
                //     icon: Icon(
                //       Icons.add,
                //       color: MyStyles.mainColor,
                //       size: ScreenUtil().setHeight(24),
                //     ),
                //     onPressed: () {
                //       DialogHelper.instance.showCreatePlaylistDialog(context);
                //     },
                //   ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     vertical: ScreenUtil().setWidth(23),
          //   ),
          //   child: SearchButton(
          //     title: indexSelected == 0
          //         ? 'Search Youtube Playlist'
          //         : 'Search Youtube Artist',
          //     onTap: () {
          //       // Utils.navigatePage(context, SearchChannelView());
          //       showModalBottomSheet(
          //         context: context,
          //         isScrollControlled: true,
          //         builder: (_) {
          //           return SearchChannelView(
          //             searchPlaylist: indexSelected == 0,
          //           );
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }

  Widget _tab(BuildContext context, String title, int index) {
    int indexSelected = 0;
    return Expanded(
      child: InkWell(
        onTap: () {
          tabController!.animateTo(index);
        },
        child: Container(
          height: double.infinity,
          width: ScreenUtil().setWidth(115),
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   border: Border(
          //     bottom: index == indexSelected
          //         ? const BorderSide(
          //             width: 2,
          //             color: Const.color_primary,
          //           )
          //         : BorderSide.none,
          //   ),
          // ),
          child: Text(
            title,
            style: AppStyles.title(
              context,
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: index == indexSelected ? AppStyles.mainColor : null,
            ),
          ),
        ),
      ),
    );
  }
}
