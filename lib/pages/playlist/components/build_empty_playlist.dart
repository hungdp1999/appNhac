import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuildEmptyPlayList extends StatelessWidget {
  final bool enableDarkMode;
  const BuildEmptyPlayList({
    Key? key,
    this.enableDarkMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final enableDarkMode = BlocProvider.of<AppCubit>(context).enableDarkMode;
    return Container(
      // height: MediaQuery.of(context).size.height - 250,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'homeMyPlaylist'.tr(),
                style: AppStyles.title(context,
                    fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 15),
            Image.asset(
              AppIcons.icNoSong,
              height: 90,
            ),
            const SizedBox(height: 10),
            Text(
              'noPlaylist'.tr(),
              style: AppStyles.copyStyle(
                fontSize: 16,
                color: AppStyles.grey3,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // DialogHelper.instance.showCreatePlaylistDialog(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: enableDarkMode
                        ? Colors.white12
                        : const Color(0xffF5F6F7),
                    border: Border.all(
                      color: enableDarkMode
                          ? Colors.white24
                          : const Color(0xffE5E7EA),
                    ),
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                // shape: RoundedRectangleBorder(
                //     side: BorderSide(
                //       color: enableDarkMode
                //           ? Colors.white24
                //           : const Color(0xffE5E7EA),
                //     ),
                //     borderRadius: BorderRadius.circular(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: AppStyles.mainColor,
                      size: 24,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'createNewPlaylist'.tr(),
                      style: AppStyles.title(
                        context,
                        color: AppStyles.mainColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                // _handleImportPlaylist(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: enableDarkMode
                        ? Colors.white12
                        : const Color(0xffF5F6F7),
                    border: Border.all(
                      color: enableDarkMode
                          ? Colors.white24
                          : const Color(0xffE5E7EA),
                    ),
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppIcons.iImportPlaylist,
                      color: AppStyles.mainColor,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'importYoutubePlaylist'.tr(),
                      style: AppStyles.title(
                        context,
                        color: AppStyles.mainColor,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future _handleImportPlaylist(BuildContext context) async {
  //   final type =
  //       await DialogHelper.instance.showImportOptionPlaylistDialog(context);
  //   if (type == 0) {
  //     DialogHelper.instance.showImportPlaylistDialog(context, 0);
  //   } else if (type == 1) {
  //     DialogHelper.instance.showImportPlaylistDialog(context, 1);
  //   }
  // }
}
