import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 15 : 12;
  static double fontSizeSemiSmall = Get.context!.width >= 1300 ? 15 : 13;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 17 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 20 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 28 : 24;
  static double fontSizeForReview = Get.context!.width >= 1300 ? 36 : 36;

  //cart item height
  static double cartItemHeight = Get.context!.width >= 1300 ? 150 : 110;

  static const double paddingSizeMint = 2.0;
  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeRadius = 8.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeDefault = 15.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;
  static const double paddingSizeExtraMoreLarge = 40.0;

  static const double pagesBottomPadding = 100.0;
  static const double logoSize = 200.0;
  static const double cartWidgetSize = 30.0;
  static const double customAppBarSize = 70.0;
  static const double preferredSize = 50.0;
  static const double addressItemHeight = 100.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double radiusExtraLarge = 20.0;
  static const double radiusExtraMoreLarge = 50.0;

  // static const double WEB_MAX_WIDTH = 1170;
  static const double tabMinimumSize = 650;

  static const double searchBerSize = 55;
  static const double floatingButtonHeight = 35;
  static const double cartDialogPadding = 80;
  static const double addAddressHeight = 60;
  static const double addAddressWidth = 160;
  static const double supportLogoHeight = 242;
  static const double supportLogoWidth = 200;
}
