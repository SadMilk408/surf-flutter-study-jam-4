import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/magic_ball_widgets/magic_ball_animate.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/presentation/ball_screen/settings_list.dart';

/// Widget for show page with MagicBall
class MagicBallScreen extends ConsumerWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      drawer: const Drawer(
        child: SettingsList(),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MagicBallAnimate(),
              SizedBox(height: 50),
              Text(
                'Нажмите на шар \n или потрясите телефон',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
