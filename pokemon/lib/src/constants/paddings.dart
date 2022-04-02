import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppPaddings {
  const AppPaddings._();

  static void initProportionedPaddings() {
    small = small.sp;
    normal = normal.sp;
  }

  static double normal = 16;
  static double small = 8;
}
