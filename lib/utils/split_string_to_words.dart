import 'package:animated_text_kit/animated_text_kit.dart';

extension SplitTextTo on String {
  List<FadeAnimatedText> splitTextToAnimatedWords() {
    final List<String> listString = split(' ');
    List<FadeAnimatedText> listAnimatedText = [];

    for (var i = 0; i < listString.length; i++) {
      listAnimatedText.add(FadeAnimatedText(listString[i]));
    }

    return listAnimatedText;
  }
}
