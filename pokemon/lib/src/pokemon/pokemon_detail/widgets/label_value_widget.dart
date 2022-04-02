import 'package:flutter/material.dart';
import 'package:pokemon/src/constants/constants.dart';

class LabelValueWidget extends StatelessWidget {
  final String value;
  final String label;
  const LabelValueWidget({
    required this.label,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: FontSizes.tiny,
            fontWeight: FontWeights.w500,
            color: AppColors.textColorGrey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: FontSizes.small,
            fontWeight: FontWeights.w400,
            color: AppColors.textColorBlack,
          ),
        )
      ],
    );
  }
}
