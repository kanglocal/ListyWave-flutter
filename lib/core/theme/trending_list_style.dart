import 'package:flutter/painting.dart';

/// web `src/lib/constants/trendingListCustomStyle.ts`. index 는 0..11 이다.
abstract final class TrendingListStyle {
  static const List<double> wrapperWidth = [
    258, 190, 258, 172, 258, 190, 258, 172, 258, 190, 258, 190, //
  ];

  static const List<EdgeInsets> padding = [
    EdgeInsets.symmetric(vertical: 68, horizontal: 52),
    EdgeInsets.symmetric(vertical: 68, horizontal: 29),
    EdgeInsets.symmetric(vertical: 68, horizontal: 52),
    EdgeInsets.symmetric(vertical: 68, horizontal: 20),
    EdgeInsets.symmetric(vertical: 68, horizontal: 52),
    EdgeInsets.symmetric(vertical: 68, horizontal: 29),
    EdgeInsets.symmetric(vertical: 68, horizontal: 52),
    EdgeInsets.symmetric(vertical: 68, horizontal: 20),
    EdgeInsets.symmetric(vertical: 68, horizontal: 52),
    EdgeInsets.symmetric(vertical: 68, horizontal: 29),
    EdgeInsets.symmetric(vertical: 68, horizontal: 52),
    EdgeInsets.symmetric(vertical: 68, horizontal: 29),
  ];

  static const List<double> borderRadius = [
    80, 180, 80, 30, 80, 180, 80, 30, 80, 180, 80, 180, //
  ];
}
