import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class PokemonDetailCardUI extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonDetailCardUI({
    required this.pokemon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textPadding = EdgeInsets.only(left: AppPaddings.p10.w);
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(
        PokemonDetailPage.routeName,
        arguments: pokemon,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: pokemon.pokemonColor,
              child: pokemon.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: pokemon.imageUrl,
                      fit: BoxFit.fill,
                      placeholder: (_, __) => const LoadingWidget(),
                    )
                  : const PokeBall(),
            ),
          ),
          AppPaddings.p8.verticalSpace,
          Padding(
            padding: textPadding,
            child: Text(
              pokemon.id.formatted,
              style: TextStyle(
                fontSize: FontSizes.tiny,
                color: AppColors.textColorGrey,
                fontWeight: FontWeights.w400,
              ),
            ),
          ),
          Padding(
            padding: textPadding,
            child: Text(
              pokemon.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: FontSizes.small,
                color: AppColors.textColorBlack,
                fontWeight: FontWeights.w600,
              ),
            ),
          ),
          AppPaddings.p10.verticalSpace,
          Padding(
            padding: textPadding,
            child: Text(
              pokemon.typesString,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: FontSizes.tiny,
                color: AppColors.textColorGrey,
                fontWeight: FontWeights.w400,
              ),
            ),
          ),
          AppPaddings.p10.verticalSpace,
        ],
      ),
    );
  }
}

extension PokemonIdFormatter on PokemonId {
  String get formatted {
    if (this < 10) {
      return '#00$this';
    } else if (this < 100) {
      return '#0$this';
    } else {
      return '#$this';
    }
  }
}
