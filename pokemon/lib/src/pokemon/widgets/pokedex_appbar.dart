import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/pokemon.dart';
import 'package:pokemon/src/utils/helper_extensions.dart';

class PokedexAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PokedexAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const PokeBall(),
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
