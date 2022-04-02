import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class PokemonSliverHeader extends SliverPersistentHeaderDelegate {
  final Pokemon pokemon;
  final double expandedHeight;

  static const _imageHeight = 136;

  const PokemonSliverHeader({
    required this.pokemon,
    required this.expandedHeight,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Opacity(
      opacity: disappear(shrinkOffset),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: pokemon.pokemonColor,
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.4),
              width: 1,
            ),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: CachedNetworkImage(
                imageUrl: pokemon.imageUrl,
                fit: BoxFit.fitHeight,
                height: _imageHeight.h,
              ),
              bottom: 0,
              right: AppPaddings.p16.w,
            ),
            Positioned(
              bottom: AppPaddings.p16.h,
              left: AppPaddings.p16.w,
              child: Text(
                pokemon.id.formatted,
                style: TextStyle(
                  fontSize: FontSizes.normal,
                  color: AppColors.textColorBlack,
                  fontWeight: FontWeights.w400,
                ),
              ),
            ),
            Positioned(
              top: AppPaddings.p24.h,
              left: AppPaddings.p16.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name,
                    style: TextStyle(
                      fontSize: FontSizes.bigger,
                      fontWeight: FontWeights.w700,
                      color: AppColors.textColorBlack,
                    ),
                  ),
                  Text(
                    pokemon.typesString,
                    style: TextStyle(
                      fontSize: FontSizes.normal,
                      fontWeight: FontWeights.w400,
                      color: AppColors.textColorBlack,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => _imageHeight.h;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
