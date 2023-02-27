import 'package:base_project/models/playlist_model.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/recently_played/recently_played.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'components/build_empty_playlist.dart';

class PlaylistPage extends StatefulWidget {
  const PlaylistPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage>
    with SingleTickerProviderStateMixin {
  // TabController? tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   tabController = TabController(vsync: this, length: 2);
  //   tabController!.addListener(() {
  //     if (tabController!.indexIsChanging) {
  //       setState(() {});
  //     }
  //   });
  //   // InappPurchaseService.instance.stateInappStream.stream.listen((event) {
  //   //   setState(() {});
  //   // });
  // }

  // @override
  // void dispose() {
  //   tabController!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    // return
    // BlocBuilder<PlaylistCubit, PlaylistState>(
    //   buildWhen: (_, state) => state is PlaylistListUpdate,
    //   builder: (context, state) {
    List<PlaylistModel> playlists = [];

    //     PlaylistModel favouritePlaylist = PlaylistModel();
    //     if (state is PlaylistListUpdate) {
    //       playlists = state.playlists;
    //       if (playlists.isNotEmpty) {
    //         for (final item in playlists) {
    //           if (item.title == Const.name_favourite) {
    //             favouritePlaylist = item;
    //             break;
    //           }
    //         }
    //       }
    //     }
    return GestureDetector(
      onTap: () {
        // BlocProvider.of<PlaylistCubit>(context).focusNode.unfocus();
      },
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            // backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: color,
                elevation: 0,
                centerTitle: false,
                title: Text(
                  'UPBEAT',
                  style: AppStyles.largeTitleAppBar,
                  textAlign: TextAlign.start,
                )),
            // appBar: PlaylistAppBar(
            //   tabController: tabController,
            //   playlists: playlists,
            // ),
            body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: RecentlyPlayed(),
                ),
                // if (!InappPurchaseService.instance.isVip)
                //   SliverPersistentHeader(
                //     pinned: true,
                //     delegate: SliverAppBarDelegate(
                //       minHeight: 60,
                //       maxHeight: 60,
                //       // ignore: avoid_unnecessary_containers
                //       child: Container(
                //         padding: EdgeInsets.only(
                //             left: Utils.paddingAds(
                //                 MediaQuery.of(context).size.width)),
                //         color: color,
                //         width: double.infinity,
                //         constraints: const BoxConstraints(
                //           minHeight: 60,
                //           maxHeight: 60,
                //         ),
                //         child: const BannerAdWidget(),
                //       ),
                //     ),
                //   ),
                // if (playlists.length > 2 ||
                //     favouritePlaylist.videoCount > 0)
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: SliverAppBarDelegate(
                //     minHeight: 85.h,
                //     maxHeight: 85.h,
                //     child: Container(
                //       color: color,
                //       // color: MyStyles.red,
                //       padding: const EdgeInsets.symmetric(horizontal: 10),
                //       child: PlaylistAppBar(
                //         tabController: tabController!,
                //         playlists: [],
                //       ),
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20.h
                  ),
                ),
                if (playlists.length <= 2
                // &&
                //     favouritePlaylist.videoCount == 0
                )
                  const SliverToBoxAdapter(
                    child: BuildEmptyPlayList(),
                  ),
                // if (playlists.length > 2 ||
                //     favouritePlaylist.videoCount > 0)
                // _buildbodyTab(),
                const SliverToBoxAdapter(
                    // child: BottomPaddingPlaying(),
                    ),
              ],
            )

            // TabBarView(
            //   // physics: const NeverScrollableScrollPhysics(),
            //   controller: tabController,
            //   children: const [
            //     PlaylistView(),
            //     DetailLibraryView(),
            //     // PlaylistArtistView(),
            //   ],
            // ),
            ),
      ),
    );
    //   },
    // );
  }

  // Widget _buildbodyTab() {
  //   if (tabController!.index == 0) {
  //     return SliverList(
  //       delegate: SliverChildBuilderDelegate(
  //         (context, index) {
  //           return const PlaylistView();
  //         },
  //         childCount: 1,
  //       ),
  //     );
  //   } else {
  //     return SliverList(
  //       delegate: SliverChildBuilderDelegate(
  //         (context, index) {
  //           return Container();
  //           // return const DetailLibraryView();
  //         },
  //         childCount: 1,
  //       ),
  //     );
  //   }
  // }
}
