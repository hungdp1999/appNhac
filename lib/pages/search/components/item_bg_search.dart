import 'dart:async';
import 'package:flutter/material.dart';

import 'package:base_project/styles/images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemBgSearchView extends StatelessWidget {
  final Stream stream;
  const ItemBgSearchView({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        var height = MediaQuery.of(context).size.height / 2;

        if (snapshot.data != null) {
          final offset = snapshot.data as double;
          height = height - offset;

          if (offset > height) height = 1;
        }

        return SizedBox(
          height: height,
          child: Stack(
            children: [
              Image.asset(
                AppImages.bgSearch,
                height: height,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const _TileWidget(),
            ],
          ),
        );
      },
    );
  }
}

class _TileWidget extends StatelessWidget {
  const _TileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 60, left: 50),
      alignment: Alignment.bottomLeft,
      child: Image(
        image: const AssetImage(AppImages.felling),
        height: 100.h,
        width: 200.w,
        fit: BoxFit.cover,
      ),
    );
  }
}
