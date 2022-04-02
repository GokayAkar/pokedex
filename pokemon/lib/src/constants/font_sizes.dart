import 'package:flutter_screenutil/flutter_screenutil.dart';

class FontSizes {
  const FontSizes._();

  static void initProportionedFontSizes() {
    tiny = tiny.sp;
    small = small.sp;
    normal = normal.sp;
    big = big.sp;
    bigger = bigger.sp;
    huge = huge.sp;
  }

  static double tiny = 12;
  static double small = 14;
  static double normal = 16;
  static double big = 24;
  static double bigger = 32;
  static double huge = 48;
}
