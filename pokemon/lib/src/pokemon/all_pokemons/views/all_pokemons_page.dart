import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon/src/constants/paddings.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/all_pokemons/cubits/all_pokemons_cubit.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class AllPokemonsPage extends StatelessWidget {
  const AllPokemonsPage({Key? key}) : super(key: key);

  static final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    childAspectRatio: (110 / 186).w,
    mainAxisSpacing: AppPaddings.pokemonCardSpacing.h,
    crossAxisSpacing: AppPaddings.pokemonCardSpacing.w,
  );

  static final gridPadding = EdgeInsets.symmetric(horizontal: AppPaddings.pokemonCardSpacing.w) +
      EdgeInsets.only(
        top: AppPaddings.pokemonCardSpacing.h,
      );

  @override
  Widget build(BuildContext context) {
    final pagingController = context.read<AllPokemonsCubit>().state.pagingController;
    return Scaffold(
      body: SafeArea(
        child: PagedGridView<int, PriorPokemonInfo>(
          padding: gridPadding,
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (_, item, __) => PokemonDetailCard(id: item.id),
            animateTransitions: true,
            firstPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
            newPageProgressIndicatorBuilder: (_) => const LoadingWidget(),
            firstPageErrorIndicatorBuilder: (_) => PokemonErrorCard(
              errorText: context.l10n.unknownError,
              mainAxisAlignment: MainAxisAlignment.center,
              onTap: () {
                pagingController.refresh();
              },
            ),
            newPageErrorIndicatorBuilder: (_) => PokemonErrorCard(
              errorText: context.l10n.unknownError,
              mainAxisAlignment: MainAxisAlignment.center,
              onTap: () {
                pagingController.refresh();
              },
            ),
          ),
          gridDelegate: gridDelegate,
        ),
      ),
    );
  }
}
