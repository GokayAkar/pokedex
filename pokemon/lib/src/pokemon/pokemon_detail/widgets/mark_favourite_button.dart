import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/favourite_pokemons.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class MarkFavouriteButton extends StatelessWidget {
  final PokemonId id;
  const MarkFavouriteButton({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavouritePokemonsCubit, FavouritePokemonsState>(
      builder: (context, state) {
        final isSelected = state.favouritePokemons.contains(id);
        final label = isSelected ? context.l10n.removeFromFavourites : context.l10n.markFavourite;
        final buttonColor = isSelected ? AppColors.favouriteButtonColor : AppColors.introBackgroundColor;
        final textColor = isSelected ? AppColors.introBackgroundColor : AppColors.textColorWhite;
        return AnimatedSize(
          duration: AnimationConstants.animatedSwitcherDuration,
          key: UniqueKey(),
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
            onPressed: () {
              context.read<FavouritePokemonsCubit>().updateFavourites(id);
            },
          ),
        );
      },
    );
  }
}
