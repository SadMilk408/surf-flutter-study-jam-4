import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/settings_widgets/change_color_ball.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/settings_widgets/change_curve.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/settings_widgets/change_theme.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/settings_widgets/speed_ball.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: const [
        DrawerHeader(
          child: ListTile(
            title: Text('Магический шар'),
          ),
        ),
        ChangeTheme(),
        ChangeColor(),
        SpeedBall(),
        ChangeCurveBall(),
      ],
    );
  }
}
