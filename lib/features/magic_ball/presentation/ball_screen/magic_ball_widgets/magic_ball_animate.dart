import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/domain/settings_params.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball_controller.dart';

/// Widget for show and controll Magic Ball functions
class MagicBallAnimate extends HookConsumerWidget {
  const MagicBallAnimate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// add submition from 2k for right view speed setting widget
    final controller = useAnimationController(
      duration: Duration(
        milliseconds: 2000 -
            ref
                .watch(settingsProvider)
                .floatingAnimationDuration
                .inMilliseconds,
      ),
    )..repeat(reverse: true);
    final tween = Tween<Offset>(
      begin: Offset.zero,
      end: ref.watch(settingsProvider).floatingTweenEnd,
    );
    final animate = tween.animate(CurvedAnimation(
      parent: controller,
      curve: ref.watch(settingsProvider).curves,
    ));

    ref.listen(responseBallControllerProvider, (_, state) {
      final model = ref.watch(responseBallControllerProvider);
      if (model is AsyncLoading) {
        controller.duration =
            ref.watch(settingsProvider).shakingAnimationDuration;
        tween.end = ref.watch(settingsProvider).shakingTweenEnd;
      } else {
        controller.duration =
            ref.watch(settingsProvider).floatingAnimationDuration;
        tween.end = ref.watch(settingsProvider).floatingTweenEnd;
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
