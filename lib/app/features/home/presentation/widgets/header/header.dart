import 'dart:math';

import 'package:flutter/material.dart';

import 'header_content.dart';

class HomeScreenHeader extends SliverPersistentHeaderDelegate {
  const HomeScreenHeader();

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final diff = expandedHeight - kToolbarHeight;
    final k = (diff - shrinkOffset) / diff;
    final double percentOfShrinkOffset = max(k, 0);
    return HomeHeaderContent(shrinkOffset: percentOfShrinkOffset);
  }

  double get expandedHeight => 200;
}
