import 'package:base_project/styles/styles.dart';
import 'package:flutter/material.dart';

class ProfileInfoItemWidget extends StatelessWidget {
  const ProfileInfoItemWidget({
    Key? key,
    this.title,
    this.number,
    this.onTab,
  }) : super(key: key);

  final String? title;
  final int? number;
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              text: '$number \n',
              style: AppStyles.title(
                context,
                  fontSize: 20, fontWeight: FontWeight.w700)),
          TextSpan(
              text: title,
              style:
                  AppStyles.title(context,fontSize: 12, fontWeight: FontWeight.w300)
                      .copyWith(height: 1.5))
        ]),
      ),
    );
  }
}
