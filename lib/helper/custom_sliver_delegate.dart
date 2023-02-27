import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;
  final bool isShowBackgroundImmediately;

  final Color? backgroundColor;

  final BuildContext context;

  CustomSliverDelegate(
      {required this.child,
      required this.minHeight,
      required this.maxHeight,
      this.isShowBackgroundImmediately = false,
      this.backgroundColor,
      required this.context});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = maxExtent - shrinkOffset;
    final proportion = 2 - (maxExtent / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return Theme(
      data: ThemeData.dark(),
      child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: maxExtent),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isShowBackgroundImmediately)
                AnimatedOpacity(
                  opacity: overlapsContent ? 1.0 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: double.infinity,
                    height: minHeight,
                    color: backgroundColor,
                  ),
                ),
              Container(
                color: backgroundColor?.withOpacity(1 - percent) ??
                    Colors.transparent,
                child: child,
              ),
            ],
          )),
    );
  }

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration =>
      OverScrollHeaderStretchConfiguration();

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
