import 'package:animated_text_kit/animated_text_kit.dart';

extension SplitTextTo on String {
  List<FadeAnimatedText> splitTextToAnimatedWords() {
    final List<String> listString = split(' ');
    List<FadeAnimatedText> listAnimatedText = [];

    for (var i = 0; i < listString.length - 1; i += 2) {
      listAnimatedText
          .add(FadeAnimatedText('${listString[i]} ${listString[i + 1]}'));
    }
    return listAnimatedText;
  }
}
