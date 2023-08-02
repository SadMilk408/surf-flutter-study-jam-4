import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/domain/settings_params.dart';
import 'package:surf_practice_magic_ball/gen/assets.gen.dart';
import 'package:surf_practice_magic_ball/utils/adaptive_sizes.dart';

class SizedImageBall extends ConsumerWidget {
  const SizedImageBall({
    super.key,
    required this.imagesBall,
    required this.assetGenImage,
  });

  final ImagesBall imagesBall;
  final AssetGenImage assetGenImage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: getAdaptiveSize(imagesBall, constraints.maxWidth),
        height: getAdaptiveSize(imagesBall, constraints.maxWidth),
        child: assetGenImage.image(
          fit: BoxFit.contain,
          color: ref.watch(settingsProvider).ballColor,
        ),
      );
    });
  }
}
