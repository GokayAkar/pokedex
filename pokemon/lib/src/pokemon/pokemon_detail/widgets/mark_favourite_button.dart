import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class MarkFavouriteButton extends StatelessWidget {
  final PokemonId id;
  const MarkFavouriteButton({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected = false || id == 123123;
    final label = isSelected ? context.l10n.removeFromFavourites : context.l10n.markFavourite;
    final buttonColor = isSelected ? AppColors.favouriteButtonColor : AppColors.introBackgroundColor;
    final textColor = isSelected ? AppColors.introBackgroundColor : AppColors.textColorWhite;
    return AnimatedSwitcher(
      duration: AnimationConstants.animatedSwitcherDuration,
      key: ValueKey(isSelected),
      child: FloatingActionButton.extended(
        label: Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.small,
            fontWeight: FontWeights.w700,
            color: textColor,
          ),
        ),
        backgroundColor: buttonColor,
        onPressed: () {},
      ),
    );
  }
}
