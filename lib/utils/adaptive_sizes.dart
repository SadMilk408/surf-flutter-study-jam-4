enum ImagesBall {
  ballWrap,
  smallStar,
  bigStar,
  ballError,
  ballLoading;
}

double? getAdaptiveSize(ImagesBall image, double maxWidth) {
  if (maxWidth > 1000) {
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
  } else if (1000 > maxWidth && maxWidth > 500) {
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
  } else if (500 > maxWidth) {
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
  return null;
}
