import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';

class PokedexTabBar extends StatelessWidget implements PreferredSizeWidget {
  const PokedexTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2.h,
            color: AppColors.homeBackgroundColor,
          ),
        ),
      ),
      child: TabBar(
        tabs: [
          Tab(
            text: context.l10n.allPokemons,
          ),
          Tab(
            text: context.l10n.favourites,
          ),
        ],
        indicatorWeight: 4.h,
        labelColor: AppColors.textColorBlack,
        unselectedLabelColor: AppColors.textColorGrey,
        labelStyle: TextStyle(
          fontWeight: FontWeights.w500,
          fontSize: FontSizes.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeights.w400,
          fontSize: FontSizes.normal,
        ),
        indicatorColor: AppColors.introBackgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
