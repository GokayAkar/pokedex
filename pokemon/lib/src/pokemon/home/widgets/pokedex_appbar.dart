import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';

class PokedexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  const PokedexAppBar({
    Key? key,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      bottom: bottom,
      title: SizedBox(
        height: kToolbarHeight,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: SizedBox(
                child: const PokeBall(),
                height: 24.h,
                width: 24.w,
              ),
            ),
            AppPaddings.p8.horizontalSpace,
            Text(
              context.l10n.pokedex,
              style: TextStyle(
                color: AppColors.textColorBlack,
                fontWeight: FontWeights.w700,
                fontSize: FontSizes.big,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}
