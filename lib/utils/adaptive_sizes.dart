import 'dart:io';

import 'package:flutter/widgets.dart';

enum ImagesBall {
  ballWrap,
  smallStar,
  bigStar,
  ballError,
  ballLoading;
}

double? getAdaptiveSize(ImagesBall image) {
  Size screenSize = WidgetsBinding.instance.window.physicalSize;
  if (Platform.isAndroid || Platform.isIOS) {
    if (screenSize.width > 500) {
      switch (image) {
        case ImagesBall.ballWrap:
          return 400;
        case ImagesBall.smallStar:
          return 250;
        case ImagesBall.bigStar:
          return 250;
        case ImagesBall.ballError:
          return 350;
        case ImagesBall.ballLoading:
          return 250;
      }
    }
    switch (image) {
      case ImagesBall.ballWrap:
        return 500;
      case ImagesBall.smallStar:
        return 350;
      case ImagesBall.bigStar:
        return 350;
      case ImagesBall.ballError:
        return 450;
      case ImagesBall.ballLoading:
        return 450;
    }
  }
  switch (image) {
    case ImagesBall.ballWrap:
      return 600;
    case ImagesBall.smallStar:
      return 400;
    case ImagesBall.bigStar:
      return 400;
    case ImagesBall.ballError:
      return 350;
    case ImagesBall.ballLoading:
      return 350;
  }
}
