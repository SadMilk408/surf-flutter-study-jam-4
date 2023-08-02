import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsParams {
  SettingsParams({
    this.ballColor,
    this.floatingAnimationDuration = const Duration(milliseconds: 1000),
    this.shakingAnimationDuration = const Duration(milliseconds: 100),
    this.floatingTweenEnd = const Offset(0, .05),
    this.shakingTweenEnd = const Offset(.03, 0),
    this.curves = Curves.easeInOut,
  });

  final Color? ballColor;
  final Duration floatingAnimationDuration;
  final Duration shakingAnimationDuration;
  final Offset floatingTweenEnd;
  final Offset shakingTweenEnd;
  final Curve curves;

  SettingsParams copyWith({
    Color? ballColor,
    Duration? floatingAnimationDuration,
    Duration? shakingAnimationDuration,
    Offset? floatingTweenEnd,
    Offset? shakingTweenEnd,
    Curve? curves,
  }) {
    return SettingsParams(
      ballColor: ballColor ?? this.ballColor,
      floatingAnimationDuration:
          floatingAnimationDuration ?? this.floatingAnimationDuration,
      shakingAnimationDuration:
          shakingAnimationDuration ?? this.shakingAnimationDuration,
      floatingTweenEnd: floatingTweenEnd ?? this.floatingTweenEnd,
      shakingTweenEnd: shakingTweenEnd ?? this.shakingTweenEnd,
      curves: curves ?? this.curves,
    );
  }

  @override
  String toString() {
    return 'SettingsParams(ballColor: $ballColor, floatingAnimationDuration: $floatingAnimationDuration, shakingAnimationDuration: $shakingAnimationDuration, floatingTweenEnd: $floatingTweenEnd, shakingTweenEnd: $shakingTweenEnd, curves: $curves)';
  }

  @override
  bool operator ==(covariant SettingsParams other) {
    if (identical(this, other)) return true;

    return other.ballColor == ballColor &&
        other.floatingAnimationDuration == floatingAnimationDuration &&
        other.shakingAnimationDuration == shakingAnimationDuration &&
        other.floatingTweenEnd == floatingTweenEnd &&
        other.shakingTweenEnd == shakingTweenEnd &&
        other.curves == curves;
  }

  @override
  int get hashCode {
    return ballColor.hashCode ^
        floatingAnimationDuration.hashCode ^
        shakingAnimationDuration.hashCode ^
        floatingTweenEnd.hashCode ^
        shakingTweenEnd.hashCode ^
        curves.hashCode;
  }
}

final settingsProvider = StateProvider<SettingsParams>((ref) {
  return SettingsParams();
});
