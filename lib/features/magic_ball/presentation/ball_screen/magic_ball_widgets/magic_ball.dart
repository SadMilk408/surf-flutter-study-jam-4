import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball_controller.dart';
import 'package:surf_practice_magic_ball/gen/assets.gen.dart';
import 'package:surf_practice_magic_ball/utils/adaptive_sizes.dart';
import 'package:surf_practice_magic_ball/utils/split_string_to_words.dart';
import 'package:surf_practice_magic_ball/utils/theme_controller.dart';

const floatingAnimationDuration = Duration(milliseconds: 1000);
const shakingAnimationDuration = Duration(milliseconds: 100);
const floatingTweenEnd = Offset(0, .05);
const shakingTweenEnd = Offset(.03, 0);

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

class MagicBall extends ConsumerWidget {
  const MagicBall({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lightThemeMode = ref.watch(themeModeProvider) == ThemeMode.light;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: getAdaptiveSize(ImagesBall.ballWrap),
          height: getAdaptiveSize(ImagesBall.ballWrap),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 98, 190, 221).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 30,
              ),
            ],
          ),
          child: lightThemeMode
              ? Assets.images.ballLight.image(fit: BoxFit.contain)
              : Assets.images.ballDark.image(fit: BoxFit.contain),
        ),
        AnimatedSwitcher(
          // switcher for fade effect when change state
          duration: const Duration(milliseconds: 1000),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // watch for all states
              ref.watch(responseBallControllerProvider).when(
                    data: (data) {
                      if (data == null) {
                        return Stack(
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
                        );
                      } else {
                        return AnimatedText(
                          text: data.reading,
                        );
                      }
                    },
                    error: (error, _) => SizedImageBall(
                      imagesBall: ImagesBall.ballError,
                      assetGenImage: Assets.images.ballError,
                    ),
                    loading: () => lightThemeMode
                        ? SizedImageBall(
                            imagesBall: ImagesBall.ballLoading,
                            assetGenImage: Assets.images.ballLoadingLight,
                          )
                        : SizedImageBall(
                            imagesBall: ImagesBall.ballLoading,
                            assetGenImage: Assets.images.ballLoadingDark,
                          ),
                  ),
            ],
          ),
        ),
      ],
    );
  }
}

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
    return SizedBox(
      width: getAdaptiveSize(imagesBall),
      height: getAdaptiveSize(imagesBall),
      child: assetGenImage.image(fit: BoxFit.contain),
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: text.splitTextToAnimatedWords(),
      isRepeatingAnimation: true,
      repeatForever: true,
    );
  }
}
