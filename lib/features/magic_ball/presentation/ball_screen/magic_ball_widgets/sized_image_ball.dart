import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/gen/assets.gen.dart';
import 'package:surf_practice_magic_ball/utils/adaptive_sizes.dart';

class SizedImageBall extends StatelessWidget {
  const SizedImageBall({
    super.key,
    required this.imagesBall,
    required this.assetGenImage,
  });

  final ImagesBall imagesBall;
  final AssetGenImage assetGenImage;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: getAdaptiveSize(imagesBall, constraints.maxWidth),
        height: getAdaptiveSize(imagesBall, constraints.maxWidth),
        child: assetGenImage.image(fit: BoxFit.contain),
      );
    });
  }
}
