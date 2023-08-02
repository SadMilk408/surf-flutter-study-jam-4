import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/domain/settings_params.dart';

final availableCurves = [
  'EaseInOut',
  'BounceInOut',
  'EaseInQuad',
  'LinearToEaseOut'
];

final Map<String, Curve> hashMapCurves = {
  'EaseInOut': Curves.easeInOut,
  'BounceInOut': Curves.bounceInOut,
  'EaseInQuad': Curves.easeInQuad,
  'LinearToEaseOut': Curves.linearToEaseOut,
};

class ChangeCurveBall extends ConsumerWidget {
  const ChangeCurveBall({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Сменить кривую анимации'),
      trailing: DropdownButton<String>(
        value: hashMapCurves.keys.firstWhere(
            (key) => hashMapCurves[key] == ref.watch(settingsProvider).curves),
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? value) {
          ref.read(settingsProvider.notifier).state =
              ref.read(settingsProvider).copyWith(curves: hashMapCurves[value]);
        },
        items: availableCurves.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
