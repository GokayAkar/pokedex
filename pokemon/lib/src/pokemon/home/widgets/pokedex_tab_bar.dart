import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';

class PokedexTabBar extends StatelessWidget implements PreferredSizeWidget {
  const PokedexTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: [
        Tab(
          text: context.l10n.allPokemons,
        ),
        Tab(
          text: context.l10n.favourites,
        ),
      ],
      indicatorWeight: 4,
      labelColor: AppColors.textColorBlack,
      unselectedLabelColor: AppColors.textColorGrey,
      labelStyle: const TextStyle(
        fontWeight: FontWeights.w500,
        fontSize: FontSizes.normal,
      ),
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeights.w400,
        fontSize: FontSizes.normal,
      ),
      indicatorColor: AppColors.introBackgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
