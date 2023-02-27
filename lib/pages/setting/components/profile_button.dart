import 'package:base_project/helper/const.dart';
import 'package:base_project/styles/icons.dart';
import 'package:base_project/styles/styles.dart';
import 'package:base_project/views/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double sizeImg = 60.w;
    // return BlocBuilder<AuthCubit, AuthState>(
    //   builder: (_, state) {
    //     UserModel _user;

    //     if (state is! AutheAuthenticated) {
    //       return _loginButton(context);
    //     }
    //     if (state is AutheAuthenticated) {
    //       _user = state.user;
    //     }
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const ProfileView()));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(sizeImg/2),
                child: Container(
                  width: sizeImg,
                  height: sizeImg,
                  color: Colors.red,
                  child:
                      // _user.avatar != null && _user.avatar.isNotEmpty
                      //     ? CachedNetworkImage(
                      //         imageUrl: _user.avatar,
                      //         fit: BoxFit.cover,
                      //       )
                      //     :
                      const SizedBox(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: Const.paddingHorizon.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '',
                      // _user?.name ?? '',
                      style: AppStyles.title(
                        context,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'View profile',
                      style: AppStyles.copyStyle(
                        fontSize: 12,
                        color: Const.colorSubtext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            AppIcons.icChevronRight,
            color: Const.colorSubtext,
          ),
        ],
      ),
    );
    //   },
    // );
  }

  Widget _loginButton(BuildContext context) {
    return Row(
      children: [
        // FlatButton(
        //   onPressed: () {
        //     showModalBottomSheet(
        //       backgroundColor: Const.colorBackground1,
        //       isScrollControlled: true,
        //       useRootNavigator: true,
        //       context: context,
        //       builder: (_) {
        //         return Container();
        //         // return const SignInView(closeButton: true);
        //       },
        //     );
        //   },
        //   height: ScreenUtil().setHeight(40),
        //   minWidth: (112),
        //   shape: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(30),
        //     borderSide: const BorderSide(color: AppStyles.grey3),
        //   ),
        //   child: Text(
        //     'login',
        //     // LocaleKeys.login.tr(),
        //     style: AppStyles.title(
        //       context,
        //       fontSize: 15,
        //       fontWeight: FontWeight.w500,
        //     ),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Text(
            'or',
            // LocaleKeys.or.tr(),
            style: AppStyles.title(
              context,
              fontSize: 15,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Const.colorBackground1,
              isScrollControlled: true,
              useRootNavigator: true,
              context: context,
              builder: (_) {
                return Container();
                // return const SignUpView(closeButton: true);
              },
            );
          },
          child: Text(
            'signUp',
            // LocaleKeys.signUp.tr(),
            style: AppStyles.title(context,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppStyles.mainColor),
          ),
        ),
      ],
    );
  }
}
