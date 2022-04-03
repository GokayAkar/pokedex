import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/favourite_pokemons/cubits/favourite_pokemons_cubit.dart';

class PokedexTabBar extends StatelessWidget implements PreferredSizeWidget {
  const PokedexTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 2.h,
            color: AppColors.homeBackgroundColor,
          ),
        ),
      ),
      child: TabBar(
        tabs: [
          Tab(
            text: context.l10n.allPokemons,
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.favourites,
                ),
                5.horizontalSpace,
                BlocBuilder<FavouritePokemonsCubit, FavouritePokemonsState>(
                  builder: (context, state) {
                    return Visibility(
                      visible: state.favouritePokemons.isNotEmpty,
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.introBackgroundColor,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          state.favouritePokemons.length.toString(),
                          style: TextStyle(
                            color: AppColors.textColorWhite,
                            fontSize: FontSizes.tiny,
                            fontWeight: FontWeights.w400,
                          ),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
        indicatorWeight: 4.h,
        labelColor: AppColors.textColorBlack,
        unselectedLabelColor: AppColors.textColorGrey,
        labelStyle: TextStyle(
          fontWeight: FontWeights.w500,
          fontSize: FontSizes.normal,
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeights.w400,
          fontSize: FontSizes.normal,
        ),
        indicatorColor: AppColors.introBackgroundColor,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(46);
}
