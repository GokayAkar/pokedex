import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/utils/helper_extensions.dart';

class PokedexAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  const PokedexAppBar({
    Key? key,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.textColorWhite,
      elevation: 0,
      bottom: bottom,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppPaddings.small.horizontal,
          Text(
            context.l10n.pokedex,
            style: const TextStyle(
              color: AppColors.textColorBlack,
              fontWeight: FontWeights.w700,
              fontSize: FontSizes.big,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));
}