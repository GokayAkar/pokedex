import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pokemon/src/pokemon/intro/intro.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _AdonisProgressIndicatorState createState() => _AdonisProgressIndicatorState();
}

class _AdonisProgressIndicatorState extends State<LoadingWidget> with TickerProviderStateMixin {
  late final AnimationController rotateController;
  late final Animation<double> rotateAnimation;
  late final AnimationController scaleController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    rotateController = AnimationController(
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
      vsync: this,
    );

    rotateAnimation = CurvedAnimation(
      parent: rotateController,
      curve: Curves.linearToEaseOut,
    );
    rotateController.repeat(
      min: 0,
      max: 1,
    );
    scaleController = AnimationController(
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 1),
      vsync: this,
    );

    scaleAnimation = CurvedAnimation(parent: scaleController, curve: Curves.linear);
    scaleController.repeat(
      min: 0.5,
      max: 1,
      reverse: true,
    );
  }

  @override
  void dispose() {
    rotateController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: rotateAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: SizedBox(
            height: 24.h,
            width: 24.w,
            child: const PokeBall(),
          ),
        ),
      ),
    );
  }
}
