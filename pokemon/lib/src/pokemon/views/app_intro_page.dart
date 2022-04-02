import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/pokemon.dart';
import 'package:pokemon/src/utils/helper_extensions.dart';

class AppIntroPage extends StatefulWidget {
  const AppIntroPage({Key? key}) : super(key: key);

  @override
  State<AppIntroPage> createState() => _AppIntroPageState();
}

class _AppIntroPageState extends State<AppIntroPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) async {
        await Future.delayed(const Duration(seconds: 1));
        Navigator.of(context).pushReplacementNamed(AllPokemonsPage.routeName);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.introBackgroundColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const PokeBall(),
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
