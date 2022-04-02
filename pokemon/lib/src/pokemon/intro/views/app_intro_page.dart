import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/home/home.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';

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
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
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
            AppPaddings.p16.horizontalSpace,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.pokemon.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.textColorWhite,
                    fontSize: FontSizes.normal,
                    fontWeight: FontWeights.w400,
                  ),
                ),
                Text(
                  context.l10n.pokedex,
                  style: TextStyle(
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
