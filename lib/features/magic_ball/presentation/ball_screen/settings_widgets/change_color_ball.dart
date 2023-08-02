import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/domain/settings_params.dart';

class ChangeColor extends ConsumerWidget {
  const ChangeColor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Выбрать цвет шара'),
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          elevation: 50,
          title: const Text('Цвета на выбор'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                Expanded(
                  child: BlockPicker(
                    pickerColor: Colors.white,
                    onColorChanged: (color) =>
                        ref.read(settingsProvider.notifier).state =
                            ref.read(settingsProvider.notifier).state.copyWith(
                                  ballColor: color,
                                ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Выбрать',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
