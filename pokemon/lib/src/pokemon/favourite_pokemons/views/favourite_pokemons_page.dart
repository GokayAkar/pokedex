import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/animation_constants.dart';
import 'package:pokemon/src/constants/paddings.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/all_pokemons/views/all_pokemons_page.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/favourite_pokemons.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';

class FavouritePokemonsPage extends StatelessWidget {
  const FavouritePokemonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FavouritePokemonsCubit, FavouritePokemonsState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: AnimationConstants.animatedSwitcherDuration,
          child: _Body(
            state: state,
            key: ValueKey(state.stateStatus),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final FavouritePokemonsState state;
  const _Body({required this.state, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.stateStatus) {
      case FavouritePokemonStateStatus.loading:
        return const Center(
          child: LoadingWidget(),
        );
      case FavouritePokemonStateStatus.successful:
        return GridView.builder(
          gridDelegate: AllPokemonsPage.gridDelegate,
          padding: AllPokemonsPage.gridPadding,
          itemCount: state.favouritePokemons.length,
          itemBuilder: (_, index) => PokemonDetailCard(
            id: state.favouritePokemons.elementAt(index),
            isFavourite: true,
          ),
        );
      default:
        return Column(
          children: [
            Text(context.l10n.unknownError),
            AppPaddings.p32.verticalSpace,
            IconButton(
              onPressed: () {
                context.read<FavouritePokemonsCubit>().getFavourites();
              },
              icon: const Icon(
                Icons.replay,
              ),
            ),
          ],
        );
    }
  }
}
