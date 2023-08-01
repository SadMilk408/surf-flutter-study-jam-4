import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/animated_text.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball_controller.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/sized_image_ball.dart';
import 'package:surf_practice_magic_ball/gen/assets.gen.dart';
import 'package:surf_practice_magic_ball/utils/adaptive_sizes.dart';
import 'package:surf_practice_magic_ball/utils/theme_controller.dart';

const floatingAnimationDuration = Duration(milliseconds: 1000);
const shakingAnimationDuration = Duration(milliseconds: 100);
const floatingTweenEnd = Offset(0, .05);
const shakingTweenEnd = Offset(.03, 0);

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
                        return CustomAnimatedText(
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
