import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/widgets/pokeball.dart';
import 'package:pokemon/src/utils/helper_extensions.dart';

class AppIntroPage extends StatelessWidget {
  const AppIntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.introBackgroundColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PokeBall(),
            AppPaddings.normal.horizontal,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.pokemon.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.textColorWhite,
                    fontSize: FontSizes.normal,
                    fontWeight: FontWeights.w400,
                  ),
                ),
                Text(
                  context.l10n.pokedex,
                  style: const TextStyle(
                    color: AppColors.textColorWhite,
                    fontSize: FontSizes.huge,
                    fontWeight: FontWeights.w700,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
