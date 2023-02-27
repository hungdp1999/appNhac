import 'package:base_project/components/premium_button.dart';
import 'package:base_project/helper/const.dart';
import 'package:base_project/helper/utils.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/backup_transfer/backup_transfer_view.dart';
import 'package:base_project/views/choose_country/choose_country_view.dart';
import 'package:base_project/views/language_view/language_view.dart';
import 'package:base_project/views/sleep_time/sleep_timer_view.dart';
import 'package:base_project/views/webviews/custom_webview.dart';
import 'package:base_project/views/webviews/youtube_webview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/profile_button.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // RegionModel _regionModel;

  @override
  void initState() {
    // getCurrentRegion();
    // InappPurchaseService.instance.stateInappStream.stream.listen((event) {
    //   setState(() {});
    // });
    super.initState();
  }

  // Future getCurrentRegion() async {
  //   _regionModel = await LocalStore.instance.getRegion();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).scaffoldBackgroundColor;
    // final locale = EasyLocalization.of(context).locale;
    // final checkLocal = locale?.languageCode?.toLowerCase() == 'vi';
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: color,
          centerTitle: false,
          title: Text(
            'moreHeader'.tr(),
            style: AppStyles.copyStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppStyles.mainColor),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Const.paddingHorizon.w),
                    child: const ProfileButton(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
            // ads
            // if (!InappPurchaseService.instance.isVip)
            //   SliverPersistentHeader(
            //     pinned: true,
            //     delegate: CustomSliverDelegate(
            //       context: context,
            //       backgroundColor: color,
            //       minHeight: 60,
            //       maxHeight: 60,
            //       isShowBackgroundImmediately: true,
            //       child: Container(
            //         constraints: const BoxConstraints(
            //           minHeight: 60,
            //           maxHeight: 60,
            //         ),
            //         width: double.infinity,
            //         padding: EdgeInsets.only(
            //             left: Utils.paddingAds(
            //                 MediaQuery.of(context).size.width)),
            //         child: const BannerAdWidget(),
            //       ),
            //     ),
            //   ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Const.paddingHorizon, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PremiumButton(),
                        SettingTileWidget(
                          title: 'backupTitle'.tr(),
                          subtitle: 'backupSubTile'.tr(),
                          iconData: Icons.backup,
                          // LocaleKeys.backupTitle.tr(),
                          // LocaleKeys.backupSubTile.tr(),
                          onTap: () {
                            Utils.navigatePage(
                                context, const BackupTransferView());
                            // Utils.navigatePage(
                            //     context, const BackupTransferView());
                          },
                        ),
                        SettingTileWidget(
                          title: 'ytbLogin'.tr(),
                          subtitle: 'moreSubYtbLogin'.tr(),
                          iconData: Icons.timer,
                          // title: LocaleKeys.ytbLogin.tr(),
                          // subtitle: LocaleKeys.moreSubYtbLogin.tr(),
                          onTap: () => _onYoutubeLogin(),
                        ),
                        SettingTileWidget(
                            iconData: Icons.timer,
                            title: 'moreSleepTimer'.tr(),
                            subtitle: 'moreSubSleepTimer'.tr(),
                            // iconData: Icons.timer,
                            // title: LocaleKeys.moreSleepTimer.tr(),
                            // subtitle: LocaleKeys.moreSubSleepTimer.tr(),
                            onTap: () {
                              Utils.navigatePage(
                                  context, const SleepTimerPage());
                            }),
                        SettingTileWidget(
                            onTap: () {},
                            title: 'toggleDarkMode'.tr(),
                            subtitle: 'darkTheme'.tr(),
                            iconData: Icons.backup,
                            // iconData: MdiIcons.toggleSwitchOffOutline,
                            // title: LocaleKeys.toggleDarkMode.tr(),
                            // subtitle: LocaleKeys.darkTheme.tr(),
                            actions: _buildIconSwitch()),
                        SettingTileWidget(
                          onTap: () {
                            _launchEmail();
                          },
                          title: 'moreFeedback'.tr(),
                          subtitle: 'moreSubFeedback'.tr(),
                          iconData: AppIcons.icAirPlane,
                          // title: LocaleKeys.moreFeedback.tr(),
                          // subtitle: LocaleKeys.moreSubFeedback.tr()
                        ),
                        SettingTileWidget(
                          onTap: () {},
                          title: 'moreRate'.tr(),
                          subtitle: 'moreSubRate'.tr(),
                          iconData: AppIcons.icLike,
                          // title: LocaleKeys.moreRate.tr(),
                          // subtitle: LocaleKeys.moreSubRate.tr()
                        ),
                        SettingTileWidget(
                          title: 'moreLanguage'.tr(),
                          subtitle: 'English',
                          iconData: AppIcons.icLanguage,
                          // title: LocaleKeys.moreLanguage.tr(),
                          // subtitle: checkLocal ? 'Tiếng việt' : 'English',
                          onTap: _changeLanguage,
                          // actions: SvgPicture.asset(MyIcons.ic_chevron_right,
                          //     width: 15),
                        ),
                        SettingTileWidget(
                            title: 'moreCountry'.tr(),
                            subtitle: 'moreSubCountry'.tr(),
                            iconData: AppIcons.icLanguage,
                            // title: LocaleKeys.moreLanguage.tr(),
                            // subtitle: checkLocal ? 'Tiếng việt' : 'English',
                            onTap: () {
                              _onChooseCountry();
                            }),
                        // BlocBuilder<AppCubit, AppState>(
                        //   buildWhen: (_, state) =>
                        //       state is AppTrendingChangeState,
                        //   builder: (_, state) {
                        //     if (state is AppTrendingChangeState) {
                        //       _regionModel = state.region;
                        //     }

                        //     return SettingTileWidget(
                        //       iconData: MyIcons.iTrendingActive,
                        //       title: LocaleKeys.moreCountry.tr(),
                        //       subtitle: LocaleKeys.moreSubCountry.tr(),
                        //       actions: Row(
                        //         mainAxisSize: MainAxisSize.min,
                        //         children: [
                        //           Text(
                        //             _regionModel?.name ?? '',
                        //             style: AppStyles.copyStyle(
                        //                 color: Const.color_primary),
                        //             maxLines: 2,
                        //             overflow: TextOverflow.ellipsis,
                        //           ),
                        //           SvgPicture.asset(MyIcons.ic_chevron_right,
                        //               width: 15)
                        //         ],
                        //       ),
                        //       onTap: () => _onChooseCountry(),
                        //     );
                        //   },
                        // ),
                        SettingTileWidget(
                          title: 'morePrivacy'.tr(),
                          subtitle: 'moreSubPrivacy'.tr(),
                          iconData: AppIcons.icPrivacy,
                          // title: LocaleKeys.morePrivacy.tr(),
                          // subtitle: LocaleKeys.moreSubPrivacy.tr(),
                          onTap: () => _onPrivacyPolicy(),
                        ),
                        // const BottomPaddingPlaying(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _changeLanguage() async {
    Utils.navigatePage(context, const LanguageView());
    // setState(() {});
  }

  bool enableDarkMode = false;

  Widget _buildIconSwitch() {
    return Switch(
        value: enableDarkMode,
        onChanged: (enable) {
          setState(() {
            enableDarkMode = enable;
          });
        });
    // final _bloc = BlocProvider.of<AppCubit>(context);
    // return Switch(
    //     value: _bloc.enableDarkMode,
    //     onChanged: (enable) {
    //       _bloc.changeDarkMode(enable);

    //       setState(() {});
    //     });
  }

  void _launchEmail() async {
    // final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    // String deviceName;
    // String osVersion;
    // final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    // if (Platform.isAndroid) {
    //   final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    //   deviceName = androidInfo.model;
    //   osVersion = 'Android ${androidInfo.version.release}';
    // } else {
    //   final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    //   deviceName = iosInfo.utsname.machine;
    //   osVersion = 'IOS ${iosInfo.systemName}';
    // }

    // final mailto = Mailto(
    //   to: [Const.emailFeedback],
    //   subject: 'Listenit',
    //   body:
    //       'Diagnostic Information:\nVersion: ${packageInfo.version}\nOS: $osVersion\nDevice Type: $deviceName\n',
    // );
    // launch('$mailto');
  }

  void _onChooseCountry() {
    Utils.navigatePage(context, const ChooseCountryView());
    // Utils.navigatePage(
    //   context,
    //   ChooseCountryView(
    //     regionModel: _regionModel,
    //   ),
    // );
  }

  void _onYoutubeLogin() {
    Utils.navigatePage(context, YoutubeWebview());
    // Utils.navigatePage(
    //   context,
    //   YoutubeWebview(),
    // );
  }

  void _onPrivacyPolicy() {
    Utils.navigatePage(
        context,
        CustomWebview(
          title: 'privacyPolicy'.tr(),
          url: Const.urlPolicy,
        ));
  }

  // Future<void> navigatePage(Widget widget) {
  //   return Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => widget));
  // }
}

class SettingTileWidget extends StatelessWidget {
  const SettingTileWidget({
    super.key,
    // @required this.iconPath,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
    this.actions,
    @required this.iconData,
  });

  // final String iconPath;
  // ignore: prefer_typing_uninitialized_variables
  final iconData;
  final String? title;
  final String? subtitle;
  final Function? onTap;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Const.paddingHorizon),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(),
                Padding(
                  padding: const EdgeInsets.only(left: Const.paddingHorizon),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        child: Center(
                          child: Text(
                            title ?? '',
                            style: AppStyles.copyStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: AppStyles.mainColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: actions == null
                            ? MediaQuery.of(context).size.width - 55
                            : MediaQuery.of(context).size.width - 125,
                        child: Text(
                          subtitle ?? '',
                          style: AppStyles.copyStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Const.colorSubtext),
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
              ],
            ),
            if (actions != null)
              Align(
                alignment: Alignment.centerRight,
                child: actions,
              )
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (iconData is String) {
      final String abc = iconData as String;
      if (abc.contains('.svg')) {
        return SvgPicture.asset(
          abc,
          height: 24,
          width: 24,
          fit: BoxFit.cover,
          // color: AppStyles.mainColor,
        );
      }
      return Image.asset(
        iconData as String,
        color: AppStyles.mainColor,
        height: 20,
      );
    }

    return Icon(
      iconData as IconData,
      size: 24,
      color: AppStyles.mainColor,
    );
  }
}
