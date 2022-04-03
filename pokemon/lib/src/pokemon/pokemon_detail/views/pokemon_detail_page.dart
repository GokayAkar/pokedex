import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon/src/localization/l10n.dart';
import 'package:pokemon/src/pokemon/pokemon_detail/pokemon_detail.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class PokemonDetailPage extends StatelessWidget {
  const PokemonDetailPage({
    Key? key,
  }) : super(key: key);

  static const routeName = 'pokemonDetail';

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPersistentHeader(
              delegate: PokemonSliverHeader(
                pokemon: pokemon,
                expandedHeight: 200.h,
                statusBarHeight: MediaQuery.of(context).padding.top,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 78.h,
                color: AppColors.whiteColor,
                child: Row(
                  children: [
                    AppPaddings.p16.horizontalSpace,
                    LabelValueWidget(
                      label: context.l10n.height,
                      value: pokemon.height.toString(),
                    ),
                    AppPaddings.p32.horizontalSpace,
                    LabelValueWidget(
                      label: context.l10n.weight,
                      value: pokemon.weight.toString(),
                    ),
                    AppPaddings.p32.horizontalSpace,
                    LabelValueWidget(
                      label: context.l10n.bmi,
                      value: pokemon.bmi.toStringAsPrecision(2),
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: AppPaddings.p8.verticalSpace,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(left: AppPaddings.p16.w),
                alignment: Alignment.centerLeft,
                height: 60.h,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.homeBackgroundColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  context.l10n.baseStats,
                  style: TextStyle(
                    color: AppColors.textColorBlack,
                    fontSize: FontSizes.normal,
                    fontWeight: FontWeights.w600,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => StatRow(
                  stat: pokemon.stats[index],
                ),
                childCount: pokemon.stats.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: MarkFavouriteButton(id: pokemon.id),
    );
  }
}
