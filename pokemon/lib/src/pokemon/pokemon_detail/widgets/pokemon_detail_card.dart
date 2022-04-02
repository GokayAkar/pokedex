import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class PokemonDetailCard extends StatelessWidget {
  final PokemonId id;
  const PokemonDetailCard({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailCubit>(
      create: (context) => PokemonDetailCubit(
        id: id,
        pokedex: context.read<Map<PokemonId, Pokemon>>(),
        repo: context.read<PokemonRepo>(),
      ),
      child: const PokemonDetailCardView(),
    );
  }
}

class PokemonDetailCardView extends StatelessWidget {
  const PokemonDetailCardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.whiteColor,
      child: BlocBuilder<PokemonDetailCubit, PokemonDetailState>(
        builder: (context, state) => AnimatedSwitcher(
          duration: AnimationConstants.animatedSwitcherDuration,
          key: ValueKey(
            state.status,
          ),
          child: _CardBody(
            state: state,
          ),
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final PokemonDetailState state;
  const _CardBody({
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case PokemonDetailStateStatus.loading:
        return const CircularProgressIndicator();
      case PokemonDetailStateStatus.success:
        return PokemonDetailCardUI(
          pokemon: state.pokemon!,
        );
      default:
        return PokemonErrorCard(
          errorText: state.status.getErrorMessage(context),
          onTap: () {
            context.read<PokemonDetailCubit>().getPokemon();
          },
        );
    }
  }
}

extension StatusToErrorStringConverter on PokemonDetailStateStatus {
  String getErrorMessage(BuildContext context) {
    switch (this) {
      case PokemonDetailStateStatus.notFound:
        return context.l10n.pokemonNotFound;
      case PokemonDetailStateStatus.requestFailed:
        return context.l10n.requestError;
      case PokemonDetailStateStatus.unknownError:
      default:
        return context.l10n.unknownError;
    }
  }
}
