import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/data/fake_repository_response_ball.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/data/real_repository_response_ball.dart';
import 'package:surf_practice_magic_ball/features/magic_ball/domain/random_reading_model.dart';
import 'package:translator/translator.dart';

// controller for get data about ball response
class ResponseBallController extends AutoDisposeAsyncNotifier<RandomReading?> {
  ResponseBallController(
      {this.fakeData = false}); // when need use fake(mock) data

  final bool fakeData;

  @override
  FutureOr<RandomReading?> build() {
    return null;
  }

  Future<void> getBallResponse() async {
    // with check when call this func guard from repeate request
    ref.read(timeoutProvider.notifier).state = false;

    if (Platform.isAndroid || Platform.isIOS) {
      // add vibrate effect for user
      bool canVibrate = await Vibrate.canVibrate;
      if (canVibrate) {
        Vibrate.vibrate();
      }
    }

    final ResponseBallRepositoryImpl responseBallRepository;
    // choose our repo
    if (fakeData) {
      responseBallRepository = ref.read(fakeResponseBallRepositoryProvider);
    } else {
      responseBallRepository = ref.read(realResponseBallRepositoryProvider);
    }
    state = const AsyncLoading();

    try {
      final randomReading = await responseBallRepository.getRepsonseFromBall();
      final translated =
          await randomReading.reading.translate(from: 'en', to: 'ru');
      state = AsyncValue.data(randomReading.copyWith(reading: translated.text));
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
    await Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      // after this, can do query
      ref.read(timeoutProvider.notifier).state = true;
    });
  }
}

final responseBallControllerProvider =
    AutoDisposeAsyncNotifierProvider<ResponseBallController, RandomReading?>(
  ResponseBallController.new,
);

final timeoutProvider = StateProvider<bool>((ref) {
  return true;
});
