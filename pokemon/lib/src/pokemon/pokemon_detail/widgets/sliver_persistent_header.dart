import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class PokemonSliverHeader extends SliverPersistentHeaderDelegate {
  final Pokemon pokemon;
  final double expandedHeight;
  final double statusBarHeight;

  static const _backgroundPokeballHeight = 160;

  const PokemonSliverHeader({
    required this.pokemon,
    required this.expandedHeight,
    required this.statusBarHeight,
  });

  Color _darken(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var f = 1 - percent / 100;
    return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(), (c.blue * f).round());
  }

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBar = AppBar(
      backgroundColor: pokemon.pokemonColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      iconTheme: const IconThemeData(
        color: AppColors.textColorBlack,
      ),
    );
    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: appear(shrinkOffset),
          child: appBar,
        ),
        Opacity(
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
              alignment: Alignment.topLeft,
              children: [
                appBar,
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/background_pokeball.png',
                    color: _darken(pokemon.pokemonColor, 10),
                    height: _backgroundPokeballHeight.h,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Positioned(
                  child: CachedNetworkImage(
                    imageUrl: pokemon.imageUrl,
                    fit: BoxFit.fitHeight,
                    height: 136.h,
                  ),
                  bottom: 0,
                  right: AppPaddings.p16.w,
                ),
                Positioned(
                  top: AppPaddings.p24.h + kToolbarHeight + statusBarHeight,
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
                ),
                Positioned(
                  top: maxExtent - AppPaddings.p32.h,
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
              ],
            ),
          ),
        ),
      ],
    );
  }

  double disappear(double shrinkOffset) => 1 - shrinkOffset / maxExtent;

  double appear(double shrinkOffset) => shrinkOffset / maxExtent;

  @override
  double get maxExtent => expandedHeight + kToolbarHeight + statusBarHeight;

  @override
  double get minExtent => kToolbarHeight + statusBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
