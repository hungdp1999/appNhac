import 'package:base_project/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'const.dart';

class DialogHelper {
  static final DialogHelper instance = DialogHelper._init();
  DialogHelper._init();

  void showLoading(BuildContext context, {String? text}) {
    showDialog(
      context: context,
      barrierColor: Colors.black26,
      barrierDismissible: true,
      builder: (_) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.9),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  if (text != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        text,
                        style: AppStyles.copyStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future hideLoading(BuildContext context) async {
    return Navigator.of(context, rootNavigator: true).pop();
  }

  void showCreatePlaylistDialog(BuildContext context) {
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Padding(
    //       padding: EdgeInsets.symmetric(
    //         horizontal: ScreenUtil().setWidth(Const.padding_horizon * 2),
    //       ),
    //       child: PlaylistDialog(
    //         title: LocaleKeys.createNewPlaylist.tr(),
    //         titleButton: LocaleKeys.createdPlaylistSuccess.tr(),
    //         hintText: LocaleKeys.dialogHintAddPlaylist.tr(),
    //         onSubmit: (text) {
    //           BlocProvider.of<PlaylistCubit>(context).createPlaylist(text);
    //         },
    //       ),
    //     );
    //   },
    // );
  }

  // void showImportPlaylistDialog(BuildContext context, int typeUrl) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: ScreenUtil().setWidth(Const.padding_horizon * 2),
  //         ),
  //         child: PlaylistDialog(
  //           title: LocaleKeys.importaplaylist.tr(),
  //           titleButton: LocaleKeys.import.tr(),
  //           hintText: typeUrl == 0
  //               ? LocaleKeys.dialogYoutubeUrl.tr()
  //               : 'Youtube playlist CODE',
  //           onSubmit: (text) {
  //             if (text == null || text.isEmpty) {
  //               return Utils.showToast(LocaleKeys.textNotEmpty.tr());
  //             }

  //             if (typeUrl == 0 && !text.contains('http')) {
  //               return Utils.showToast(LocaleKeys.incorrecturl.tr());
  //             }

  //             if (typeUrl == 1 && text.contains('http')) {
  //               return Utils.showToast(LocaleKeys.incorrectcode.tr());
  //             }

  //             BlocProvider.of<PlaylistCubit>(context).importPlaylist(text);
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future showImportOptionPlaylistDialog(BuildContext context) async {
  //   final bgColor = Theme.of(context).scaffoldBackgroundColor;
  //   final bool isColors = bgColor == const Color(0xff222323);
  //   return showCupertinoModalPopup(
  //     context: context,
  //     builder: (context) {
  //       return CupertinoActionSheet(
  //         title: Text(
  //           LocaleKeys.whatDoYouWanToDo.tr(),
  //           style: MyStyles.copyStyle(
  //             color: MyStyles.grey3,
  //           ),
  //         ),
  //         actions: <Widget>[
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.of(context).pop(0);
  //             },
  //             child: Text(
  //               LocaleKeys.importYoutubePlaylist.tr(),
  //               style: MyStyles.copyStyle(color: MyStyles.red, fontSize: 18),
  //             ),
  //           ),
  //           CupertinoActionSheetAction(
  //             onPressed: () {
  //               Navigator.of(context).pop(1);
  //             },
  //             child: Text(
  //               LocaleKeys.importPlaylistFromCode.tr(),
  //               style:
  //                   MyStyles.copyStyle(color: MyStyles.mainColor, fontSize: 18),
  //             ),
  //           )
  //         ],
  //         cancelButton: CupertinoActionSheetAction(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: Text(
  //             LocaleKeys.dialogDeleteUpNextButton.tr(),
  //             style: MyStyles.copyStyle(
  //               color: isColors ? Colors.white : MyStyles.grey3,
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> alertNotLogin(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: ScreenUtil().setWidth(Const.padding_horizon * 2),
  //           ),
  //           child: SelectInTwoOptionsDialog(
  //             title: LocaleKeys.notlogged.tr(),
  //             subTitle: LocaleKeys.notloggedsub.tr(),
  //             buttomLeftText: LocaleKeys.login.tr(),
  //             buttomRightTtext: LocaleKeys.signUp.tr(),
  //             onTabButtomLeft: () {
  //               Utils.navigatePage(context, const SignInView());
  //             },
  //             onTabButtomRight: () {
  //               Utils.navigatePage(context, const SignUpView());
  //             },
  //           ));
  //     },
  //   );
  // }

  // Future<void> alertDeviceMaybeHot(
  //     BuildContext context, Function onContinue) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Padding(
  //           padding: EdgeInsets.symmetric(
  //             horizontal: ScreenUtil().setWidth(Const.padding_horizon * 2),
  //           ),
  //           child: SelectInTwoOptionsDialog(
  //             title: LocaleKeys.mayoverheat.tr(),
  //             subTitle: LocaleKeys.mayoverheatsub.tr(),
  //             buttomLeftText: LocaleKeys.cancel.tr(),
  //             buttomRightTtext: LocaleKeys.continues.tr(),
  //             onTabButtomLeft: () {},
  //             onTabButtomRight: onContinue,
  //           ));
  //     },
  //   );
  // }

  // Future<void> addMusicToPlaylist(BuildContext context, SongModel song) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AddSongPlaylist(song: song);
  //     },
  //   );
  // }
}
