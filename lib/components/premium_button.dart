import 'package:base_project/helper/utils.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/premium/premium_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumButton extends StatelessWidget {
  const PremiumButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final products = InappPurchaseService.instance.products;
    // String _price = '';
    // for (final item in products) {
    //   if (item.productId == Const.inapp_yearly) {
    //     _price = item.localizedPrice;
    //     break;
    //   }
    // }
    return GestureDetector(
      onTap: () {
        Utils.navigatePage(context, const PremiumView());
        // BlocProvider.of<AppCubit>(context).showPremium(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        height: ScreenUtil().setHeight(40),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: AppStyles.gradient,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppIcons.icCrown,
              width: 20,
            ),
            const SizedBox(width: 6),
            Text(
              'morePremium'.tr(),
              style: AppStyles.copyStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
    //   FlatButton(
    //   color: AppStyles.mainColor,
    //   height: ScreenUtil().setHeight(40),
    //   minWidth: double.infinity,
    //   shape: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(ScreenUtil().setHeight(48) / 2),
    //     borderSide: const BorderSide(color: AppStyles.mainColor),
    //   ),
    //   onPressed: () {
    //     BlocProvider.of<AppCubit>(context).showPremium(context);
    //   },

    //   child: Text(
    //     'Go Premium for $_price',
    //     style: AppStyles.copyStyle(
    //       fontSize: 15,
    //     ),
    //   ),
    // );
  }
}
