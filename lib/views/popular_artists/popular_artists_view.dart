// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screen_util.dart';
// import 'package:upbeat_v2/app/const.dart';
// import 'package:upbeat_v2/app/my_icons.dart';
// import 'package:upbeat_v2/app/my_styles.dart';
// import 'package:upbeat_v2/app/utils.dart';
// import 'package:upbeat_v2/components/banner_ad_widget.dart';
// import 'package:upbeat_v2/components/components.dart';
// import 'package:upbeat_v2/models/artist_model.dart';
// import 'package:upbeat_v2/models/country_model.dart';
// import 'package:upbeat_v2/services/inapp_purchase/inapp_purchase.dart';
// import 'package:upbeat_v2/services/network/network.dart';
// import 'package:upbeat_v2/views/artist_detail/artist_detail_view.dart';
// import 'package:upbeat_v2/views/search_channel/search_channel_view.dart';
// import 'package:upbeat_v2/generated/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';

// class PopularArtistsView extends StatefulWidget {
//   final List<ArtistModel> artists;
//   final RegionModel region;

//   const PopularArtistsView({this.artists, this.region});

//   @override
//   _PopularArtistsViewState createState() => _PopularArtistsViewState();
// }

// class _PopularArtistsViewState extends State<PopularArtistsView> {
//   // AppCubit _appCubit;
//   // bool _darkMode;

//   @override
//   void initState() {
//     InappPurchaseService.instance.stateInappStream.stream.listen((event) {
//       setState(() {});
//     });
//     // _appCubit = BlocProvider.of<AppCubit>(context);
//     // _darkMode = _appCubit.enableDarkMode;
//     // _appCubit.listen((state) {
//     //   if (state is EnableDarkModeState) {
//     //     _darkMode = state.enableDarkMode;
//     //     setState(() {});
//     //   }
//     // });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Color color = Theme.of(context).scaffoldBackgroundColor;
//     final size = MediaQuery.of(context).size;
//     final sizeImage = (size.width - Const.padding_horizon * 6) / 3;
//     const Color colorBg = Colors.transparent;
//     final listTab = [
//       widget.region?.name ?? 'Country',
//       LocaleKeys.globalTrending.tr()
//     ];
//     return DefaultTabController(
//         length: listTab.length,
//         child: SafeArea(
//           top: false,
//           bottom: false,
//           child: Scaffold(
//               appBar: AppBar(
//                 leadingWidth: 0,
//                 leading: const SizedBox.shrink(),
//                 titleSpacing: 1,
//                 title: Row(
//                   children: [
//                     IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back_ios,
//                           size: 25,
//                           color: MyStyles.grey3,
//                         ),
//                         onPressed: () => Navigator.of(context).pop()),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () => Utils.navigatePage(
//                             context,
//                             const SearchChannelView(
//                               searchPlaylist: false,
//                             )),
//                         child: Container(
//                           height: 40,
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           decoration: BoxDecoration(
//                             color: MyStyles.grey4,
//                             border: Border.all(color: MyStyles.grey4),
//                             borderRadius: BorderRadius.circular(32),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Text(
//                                   LocaleKeys.searchHintAritst.tr(),
//                                   style: MyStyles.copyStyle(
//                                     fontSize: 16,
//                                     color: MyStyles.grey2,
//                                   ),
//                                 ),
//                               ),
//                               const Image(
//                                 image: AssetImage(MyIcons.iSearch),
//                                 width: 24,
//                                 height: 24,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       // )
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     )
//                   ],
//                 ),
//                 bottom: PreferredSize(
//                   preferredSize: const Size.fromHeight(100),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       if (listTab.length != 1)
//                         Align(
//                           // alignment: Alignment.center,
//                           child: TabBar(
//                             isScrollable: true,
//                             labelColor: MyStyles.mainColor,
//                             unselectedLabelColor: color == MyStyles.grey
//                                 ? Colors.white
//                                 : Colors.black,
//                             labelStyle: MyStyles.title(
//                               context,
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             unselectedLabelStyle: MyStyles.title(
//                               context,
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             indicatorColor: color == MyStyles.grey
//                                 ? Colors.white
//                                 : Colors.black,
//                             indicatorWeight: 0.0001,
//                             // indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
//                             labelPadding: const EdgeInsets.only(
//                                 left: 50, right: 50, bottom: 5),
//                             tabs: List.generate(
//                               listTab.length,
//                               (index) => Text(
//                                 listTab[index],
//                               ),
//                             ),
//                           ),
//                         ),
//                       StreamBuilder(
//                         stream: InappPurchaseService
//                             .instance.stateInappStream.stream,
//                         builder: (context, snapshot) {
//                           return !InappPurchaseService.instance.isVip
//                               ? Container(
//                                   margin:
//                                       const EdgeInsets.symmetric(vertical: 5),
//                                   color: colorBg,
//                                   // padding: EdgeInsets.only(
//                                   //   left: Utils.paddingAds(
//                                   //       MediaQuery.of(context).size.width),
//                                   // ),
//                                   child: const BannerAdWidget(),
//                                 )
//                               : const SizedBox.shrink();
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//                 centerTitle: false,
//               ),
//               body: TabBarView(
//                 children: [
//                   buildFutureBuilder(sizeImage, langCode: widget.region?.code),
//                   buildFutureBuilder(sizeImage),
//                 ],
//               )

//               // GridView.builder(
//               //   padding: const EdgeInsets.symmetric(
//               //       horizontal: Const.padding_horizon, vertical: 10),
//               //   itemCount: (artists.length / 2).floor(),
//               //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               //     crossAxisCount: 3,
//               //     childAspectRatio: sizeImage / (sizeImage + 30),
//               //   ),
//               //   itemBuilder: (BuildContext context, int index) {
//               //     return RoundVerticalItem(
//               //       onTap: () {
//               //         Utils.navigatePage(
//               //             context, ArtistDetailView(artistModel: artists[index]));
//               //       },
//               //       sizeImage: Size(sizeImage, sizeImage),
//               //       title: artists[index].name,
//               //       image: artists[index].imgPath,
//               //     );
//               //   },
//               // ),
//               ),
//         ));
//   }

//   FutureBuilder<List<ArtistModel>> buildFutureBuilder(double sizeImage,
//       {String langCode}) {
//     return FutureBuilder(
//         future: ApiClient.instance.getTopArtist(langCode ?? 'US'),
//         builder: (context, snapshot) {
//           final ids = Set();
//           List<ArtistModel> artists2;
//           int length = 30;
//           final isWaiting = snapshot.connectionState == ConnectionState.waiting;
//           if (snapshot.data != null) {
//             artists2 = snapshot.data;
//             artists2.retainWhere((element) => ids.add(element.name));
//             length = artists2.length;
//           }
//           final _widthItem = ScreenUtil().setWidth(100);
//           return GridView.builder(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: Const.padding_horizon, vertical: 10),
//             itemCount: length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               childAspectRatio: sizeImage / (sizeImage + 30),
//             ),
//             itemBuilder: (BuildContext context, int index) {
//               if (isWaiting) {
//                 return Padding(
//                   padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
//                   child: RoundVerticalShimmer(
//                     sizeImage: Size(_widthItem, _widthItem),
//                   ),
//                 );
//               }
//               if (index == length) {
//                 return const BottomPaddingPlaying();
//               }
//               return RoundVerticalItem(
//                 onTap: () {
//                   Utils.navigatePage(context,
//                       ArtistDetailView(artistModel: widget.artists[index]));
//                 },
//                 sizeImage: Size(sizeImage, sizeImage),
//                 title: artists2[index].name,
//                 image: artists2[index].imgPath,
//               );
//             },
//           );
//         });
//   }
// }
