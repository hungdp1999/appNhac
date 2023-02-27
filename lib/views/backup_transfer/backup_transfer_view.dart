import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'components/restore_backup_view.dart';

class BackupTransferView extends StatefulWidget {
  const BackupTransferView({Key? key}) : super(key: key);

  @override
  State<BackupTransferView> createState() => _BackupTransferViewState();
}

class _BackupTransferViewState extends State<BackupTransferView> {
  // BackupCubit _backupCubit;

  // @override
  // void initState() {
  //   super.initState();
  //   _backupCubit = BlocProvider.of<BackupCubit>(context);

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     if (BlocProvider.of<AuthCubit>(context).checkLogin()) {
  //       _backupCubit.updateBackupCode(
  //           BlocProvider.of<AuthCubit>(context).user.backupCode);
  //     } else {
  //       _backupCubit.generateCode();
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<BackupCubit, BackupState>(
    //   buildWhen: (_, state) => state is BackupKeyLoaded,
    //   builder: (context, state) {
    //     BackupData _backupData;
    //     if (state is BackupKeyLoaded) {
    //       _backupData = state.backupData;
    //     }
    final color = Theme.of(context).scaffoldBackgroundColor;
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color,
          centerTitle: true,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: EdgeInsets.all(8.w),
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
            'backupAndResponse',
            // LocaleKeys.backupAndResponse.tr(),
            style: AppStyles.copyStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppStyles.mainColor),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: Const.paddingHorizon.w),
          children: [
            SizedBox(
              height: Const.paddingHorizon.w * 2,
            ),
            Column(
              children: [
                GestureDetector(
                  // onLongPress: () => Utils.copyToClipboard(_backupData?.code),
                  // onDoubleTap: () => Utils.copyToClipboard(_backupData?.code),
                  child: Text(
                    // _backupData?.code ??
                    '',
                    style: AppStyles.copyStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w600,
                      color: AppStyles.mainColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  'Make sure to save this code',
                  style: AppStyles.copyStyle(
                      fontSize: 18, color: Const.colorButton),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                MaterialButton(
                  onPressed: () async {
                    // DialogHelper.instance
                    //     .showLoading(context, text: 'Backing up');
                    // await _backupCubit.backupToCode();
                    // DialogHelper.instance.hideLoading(context);
                  },
                  color: AppStyles.mainColor,
                  height: ScreenUtil().setHeight(45),
                  minWidth: ScreenUtil().setWidth(218),
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: AppStyles.mainColor,
                      ),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'backupToCode',
                    // LocaleKeys.backupToCode.tr(),
                    style: AppStyles.copyStyle(),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                _buildButton(
                  'restoreFromCode',
                  // LocaleKeys.restoreFromCode.tr(),
                  () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return const RestoreBackupView();
                      },
                    );
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                _buildButton(
                  'viewPreviousBackup',
                  // LocaleKeys.viewPreviousBackup.tr(),
                  () {},
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Const.paddingHorizon.w * 2,
                  ),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '',
                          // '${LocaleKeys.lastBackup.tr()}: ${Utils.formatDateFull(_backupData?.lastBackup)} \n\n${LocaleKeys.backupDes.tr()}.',
                          style: AppStyles.copyStyle(
                            color: Const.colorSubtext,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
    //     },
    //   );
  }

  Widget _buildButton(String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 5),
        height: ScreenUtil().setHeight(52),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 1, color: AppStyles.grey3)),
        // color: Colors.transparent,
        // height: ScreenUtil().setHeight(52),
        // padding: const EdgeInsets.only(left: 15, right: 5),
        // shape: OutlineInputBorder(
        //   borderSide: const BorderSide(color: AppStyles.grey3),
        //   borderRadius: BorderRadius.circular(5),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyles.title(
                context,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            SvgPicture.asset(AppIcons.icArrowFoward)
          ],
        ),
      ),
    );
  }
}
