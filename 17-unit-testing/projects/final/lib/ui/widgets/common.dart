import 'package:flutter/widgets.dart';

typedef Sliver = Widget;

const emptyWidget = SizedBox();

const emptySliverWidget = SliverToBoxAdapter(child: emptyWidget);

const allPadding16 = EdgeInsets.all(16.0);
const allPadding8 = EdgeInsets.all(8.0);
const horizontalPadding16 = EdgeInsets.symmetric(horizontal: 16.0);
const horizontalPadding8 = EdgeInsets.symmetric(horizontal: 8.0);
const topPadding16 = EdgeInsets.only(top: 16.0);
const topPadding8 = EdgeInsets.only(top: 8.0);

const bottomPadding32 = EdgeInsets.only(bottom: 32.0);

const sizedW8 = SizedBox(width: 8);
const sizedW16 = SizedBox(width: 16);
const sizedH16 = SizedBox(height: 16);
const sizedH8 = SizedBox(height: 8);
