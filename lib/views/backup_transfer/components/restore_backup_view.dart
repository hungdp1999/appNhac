import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/backup_transfer/components/popup_restore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RestoreBackupView extends StatefulWidget {
  // final BackupCubit backupCubit;
  const RestoreBackupView({
    super.key,
    // this.backupCubit,
  });

  @override
  State<RestoreBackupView> createState() => _RestoreBackupViewState();
}

class _RestoreBackupViewState extends State<RestoreBackupView> {
  final TextEditingController codeController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          // leading: TextButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: Text(
          //     "Cancel",
          //     style: AppStyles.copyStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.w500,
          //       color: Const.color_button,
          //     ),
          //   ),
          // ),
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.icBack,
                height: 20,
                width: 20,
                fit: BoxFit.cover,
                color: AppStyles.grey3,
              ),
            ),
          ),
          title: Text(
            "Enter Code",
            style: AppStyles.copyStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppStyles.mainColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (codeController.text.isEmpty) {
                  // return Utils.showToast(LocaleKeys.codeEmpty.tr());
                }
                _focusNode.unfocus();
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) => const PopupRestore(
                    // onMerge: _onMerge,
                    // onOverwrite: _onOverwrite,
                  ),
                );
              },
              child: Text(
                '',
                // LocaleKeys.continues.tr(),
                style: AppStyles.copyStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppStyles.mainColor,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Column(
              children: [
                TextField(
                  textAlign: TextAlign.center,
                  cursorColor: Const.colorLogo,
                  controller: codeController,
                  focusNode: _focusNode,
                  style: AppStyles.copyStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w600,
                    color: Const.colorLogo,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "code",
                    hintStyle: AppStyles.copyStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: AppStyles.white.withOpacity(0.7),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: Const.paddingHorizon.w * 3,
                      left: Const.paddingHorizon.w * 2,
                      right: Const.paddingHorizon.w * 2),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppStyles.copyStyle(
                            fontSize: 18, color: Const.colorSubtext),
                        text: '',
                        // LocaleKeys.enterBackup.tr(),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future _onMerge() async {
    // DialogHelper.instance.showLoading(context);
    // await widget.backupCubit.merge(codeController.text);
    // DialogHelper.instance.hideLoading(context);
  }

  Future _onOverwrite() async {
    // DialogHelper.instance.showLoading(context);
    // await widget.backupCubit.overwrite(codeController.text);
    // DialogHelper.instance.hideLoading(context);
  }
}
