import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball_controller.dart';

/// Widget for show and controll Magic Ball functions
class MagicBallAnimate extends HookConsumerWidget {
  const MagicBallAnimate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useAnimationController(
      duration: floatingAnimationDuration,
    )..repeat(reverse: true);
    final tween = Tween<Offset>(
      begin: Offset.zero,
      end: floatingTweenEnd,
    );
    final animate = tween.animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    ref.listen(responseBallControllerProvider, (_, state) {
      final model = ref.watch(responseBallControllerProvider);
      if (model is AsyncLoading) {
        controller.duration = shakingAnimationDuration;
        tween.end = shakingTweenEnd;
      } else {
        controller.duration = floatingAnimationDuration;
        tween.end = floatingTweenEnd;
      }

      controller.repeat(reverse: true);
    });

    return GestureDetector(
      onTap: () {
        // check for escape many request while loading data
        if (ref.read(timeoutProvider.notifier).state) {
          ref.read(responseBallControllerProvider.notifier).getBallResponse();
        }
      },
      child: Column(
        children: <Widget>[
          SlideTransition(
            position: animate,
            child: const MagicBall(),
          )
        ],
      ),
    );
  }
}
