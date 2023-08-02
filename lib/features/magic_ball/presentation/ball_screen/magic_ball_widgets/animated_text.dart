import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/utils/split_string_to_words.dart';

class CustomAnimatedText extends ConsumerWidget {
  const CustomAnimatedText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedTextKit(
      animatedTexts: text.splitTextToAnimatedWords(),
      isRepeatingAnimation: true,
      repeatForever: true,
    );
  }
}
