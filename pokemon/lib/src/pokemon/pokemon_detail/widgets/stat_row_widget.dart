import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/constants/constants.dart';
import 'package:pokemon_api/pokemon_repo.dart';

class StatRow extends StatelessWidget {
  final PokemonStat stat;
  const StatRow({
    required this.stat,
    Key? key,
  }) : super(key: key);

  Color _interpolate(double progress, List<Color> colors) {
    try {
      int prevIndex = (progress * (colors.length - 1)).floor();
      double currProgress = (progress * (colors.length - 1)) - prevIndex;
      Color prevColor = colors[prevIndex];

      if (currProgress == 0) {
        return prevColor;
      }

      Color nextColor = colors[prevIndex + 1];

      return Color.lerp(prevColor, nextColor, currProgress) ?? AppColors.homeBackgroundColor;
    } catch (_) {
      //TODO log error if ever stat value comes bigger than 100
      return AppColors.homeBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = 4.h;
    final barBorderRadius = BorderRadius.circular(30);
    final barWidth = 343.w;

    return Container(
      padding: EdgeInsets.only(left: AppPaddings.p16.w),
      alignment: Alignment.center,
      height: 75.h,
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Text(
                stat.name,
                style: TextStyle(
                  color: AppColors.textColorGrey,
                  fontSize: FontSizes.small,
                  fontWeight: FontWeights.w400,
                ),
              ),
              AppPaddings.p4.horizontalSpace,
              Text(
                stat.value.toString(),
                style: TextStyle(
                  color: AppColors.textColorBlack,
                  fontSize: FontSizes.small,
                  fontWeight: FontWeights.w500,
                ),
              ),
            ],
          ),
          AppPaddings.p8.verticalSpace,
          Container(
            width: barWidth,
            height: barHeight,
            decoration: BoxDecoration(
              color: AppColors.homeBackgroundColor,
              borderRadius: barBorderRadius,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: AnimatedContainer(
                height: barHeight,
                decoration: BoxDecoration(
                  borderRadius: barBorderRadius,
                  color: _interpolate(
                    stat.value / 100,
                    [Colors.red, Colors.amber, Colors.green],
                  ),
                ),
                duration: AnimationConstants.animatedSwitcherDuration,
                width: barWidth * stat.value / 100,
              ),
            ),
          )
        ],
      ),
    );
  }
}
