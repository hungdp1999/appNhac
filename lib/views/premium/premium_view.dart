import 'package:base_project/helper/const.dart';
import 'package:base_project/helper/utils.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/webviews/custom_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PremiumView extends StatefulWidget {
  const PremiumView({Key? key}) : super(key: key);

  @override
  State<PremiumView> createState() => _PremiumViewState();
}

class _PremiumViewState extends State<PremiumView> {
  // AppCubit _appCubit;
  // bool _darkMode;

  final List<String> _notes = [
    'removeAllAds', 'reoderTracks', 'backupPremium'
    // LocaleKeys.removeAllAds.tr(),
    // LocaleKeys.reoderTracks.tr(),
    // LocaleKeys.backupPremium.tr(),
  ];

  // @override
  // void initState() {
  //   _appCubit = BlocProvider.of<AppCubit>(context);
  //   _darkMode = _appCubit.enableDarkMode;
  //   _appCubit.listen((state) {
  //     if (state is EnableDarkModeState) {
  //       _darkMode = state.enableDarkMode;
  //       setState(() {});
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w),
              height: 80.w,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_header.png'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 3),
                    child: InkWell(
                      onTap: () {
                        // InappPurchaseService.instance.restore();
                      },
                      child: Text(
                        'restore',
                        // LocaleKeys.restore.tr(),
                        style: AppStyles.copyStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 30.w),
                    child: Text(
                      'Premium',
                      style: AppStyles.copyStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SvgPicture.asset(
                      AppIcons.icClose,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    Text(
                      'whatInclude',
                      // LocaleKeys.whatInclude.tr(),
                      style: AppStyles.copyStyle(
                        color: AppStyles.mainColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Column(
                      children: List.generate(
                        _notes.length,
                        (index) => _note(_notes[index]),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    // Column(
                    //   children: List.generate(
                    //     InappPurchaseService.instance.products.length,
                    //     (index) {
                    //       final item =
                    //           InappPurchaseService.instance.products[index];
                    //       String icon = MyIcons.ic_music1;
                    //       Color colorText = Const.color_primary;
                    //       Color colorBackground = Colors.white;

                    //       if (item.productId == Const.inapp_yearly) {
                    //         icon = MyIcons.ic_headphones;
                    //         colorText = Colors.black;
                    //         colorBackground = const Color(0xff84BFFF);
                    //       } else if (item.productId == Const.inapp_lifetime) {
                    //         icon = MyIcons.ic_coffee;
                    //         colorText = Colors.black;
                    //         colorBackground = Const.colorPrimary;
                    //       }

                    //       String title = item.title;
                    //       if (title.contains('(')) {
                    //         title = title.substring(0, title.indexOf('('));
                    //       }

                    //       return InkWell(
                    //         onTap: () {
                    //           // InappPurchaseService.instance
                    //           //     .purchase(item.productId);
                    //         },
                    //         child: _item(
                    //           icon,
                    //           item.localizedPrice,
                    //           title,
                    //           colorText,
                    //           colorBackground,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 10.h),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.w),
                      child: Text(
                        'subscriptionTerms',
                        // LocaleKeys.subscriptionTerms.tr(),
                        style: AppStyles.copyStyle(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    _buildTermPremium(),
                    GestureDetector(
                      onTap: () => _onPrivacyPolicy(),
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: Text(
                            'morePrivacy',
                            // LocaleKeys.morePrivacy.tr(),
                            style: AppStyles.copyStyle(
                              fontSize: 14,
                              color: AppStyles.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onPrivacyPolicy() {
    Utils.navigatePage(context, const CustomWebview(
              title: 'privacyPolicy',
              url: Const.urlPolicy,
            ));
    // Utils.navigatePage(
    //   context,
    //   CustomWebview(
    //     title: 'privacyPolicy',
    //     // LocaleKeys.privacyPolicy.tr(),
    //     url: Const.urlPolicy,
    //   ),
    // );
  }

  Widget _note(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        children: [
          Image.asset(AppIcons.iCheckCircleEnable,
              width: 20, color: AppStyles.grey2),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.title(
                context,
                fontWeight: FontWeight.normal, color: AppStyles.grey2,
                //  _darkMode ? AppStyles.white : AppStyles.grey2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTermPremium() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Text(
        '- Get unlimited access to all features for {}/3month, {}/year and {}/lifetime \n\n- The payment will be charged to your iTunes account at confirmation of purchase. \n\n- The subscription automatically renews unless auto-renew is turned off at least 24 hours before the end of the current period. \n\n- Subscription may be managed and auto-renewal may be turned off by going to Account Settings after purchase. \n\n- The account will be charged for renewal within 24 hours prior to the end of the current period. \n\n- Any unused portion of a free trial period will be forfeited when the user purchases a subscription to that publication.',
        // LocaleKeys.subscriptionInfo.tr(args: [
        //   '35.000 đ',
        //   '69.000 đ',
        //   '115.000 đ',
        // ]),
        style: AppStyles.title(
          context,
          fontWeight: FontWeight.normal,
          color: AppStyles.grey2,
          // _darkMode ? AppStyles.white : AppStyles.grey2,
        ),
      ),
    );
  }

  Widget _item(String icon, String price, String timer, Color colorText,
      Color background) {
    return Container(
      height: 40.h,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon),
              SizedBox(
                width: 13.w,
              ),
              Text(
                price,
                style: AppStyles.copyStyle(
                  color: colorText,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            timer,
            style: AppStyles.copyStyle(
              color: colorText,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
