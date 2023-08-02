import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/sized_image_ball.dart';
import 'package:surf_practice_magic_ball/gen/assets.gen.dart';
import 'package:surf_practice_magic_ball/utils/adaptive_sizes.dart';

const starsFloatingAnimationDuration = Duration(seconds: 100);

class StarsWidget extends HookConsumerWidget {
  const StarsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: starsFloatingAnimationDuration,
    )..repeat(reverse: false);
    final tween = Tween(begin: 0.0, end: 1.0);
    final animate = tween.animate(controller);

    return RotationTransition(
      turns: animate,
      child: Stack(
        children: [
          SizedImageBall(
            imagesBall: ImagesBall.smallStar,
            assetGenImage: Assets.images.smallStar,
          ),
          SizedImageBall(
            imagesBall: ImagesBall.bigStar,
            assetGenImage: Assets.images.bigStars,
          ),
        ],
      ),
    );
  }
}
