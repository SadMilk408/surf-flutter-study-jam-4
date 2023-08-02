import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/domain/settings_params.dart';

class SpeedBall extends ConsumerWidget {
  const SpeedBall({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTime =
        ref.read(settingsProvider).floatingAnimationDuration.inMilliseconds;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text('Настройка скорости полета шара'),
        ),
        Slider(
          value: ref
              .watch(settingsProvider)
              .floatingAnimationDuration
              .inMilliseconds
              .toDouble(),
          max: 1500,
          min: 500,
          divisions: 300,
          label: (curTime / 100).round().toString(),
          onChanged: (double value) {
            ref.read(settingsProvider.notifier).state =
                ref.read(settingsProvider).copyWith(
                      floatingAnimationDuration: Duration(
                        milliseconds: value.floor(),
                      ),
                    );
          },
        ),
      ],
    );
  }
}
