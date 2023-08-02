import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/utils/theme_controller.dart';

/// Widget for change color scheme
class ChangeTheme extends ConsumerWidget {
  const ChangeTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return ListTile(
      title: const Text('Сменить тему'),
      onTap: () {
        ref.read(themeModeProvider.notifier).state =
            theme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      },
      trailing: Icon(
        theme == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
      ),
    );
  }
}
