import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/cart_controller.dart';
import '../../../core/helper/route_helper.dart';

class UserLogout extends StatelessWidget {
  const UserLogout({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeDefault,
          vertical: Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(Dimensions.radiusSmall),
        ),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'logout_dialog'.tr,
            style: robotoSemiBold.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Divider(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
            thickness: 1,
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(
            'are_you_sure_logout_from_device'.tr,
            style: robotoRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeSmall),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Row(
            children: [
              //no button
              Expanded(
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColorLight,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall)),
                    child: Text('no'.tr,
                        style: robotoMedium.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: Dimensions.fontSizeSmall)),
                  ),
                ),
              ),
              const SizedBox(
                width: Dimensions.paddingSizeDefault,
              ),
              // yes button
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.find<AuthController>().clearSharedData();
                    Get.find<CartController>().clearCartList();
                    Get.offAllNamed(
                        RouteHelper.getSignInRoute(RouteHelper.splash));
                  },
                  child: Container(
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiary,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall)),
                    child: Text('yes'.tr,
                        style: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: Dimensions.fontSizeSmall)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraLarge)
        ],
      ),
    );
  }
}
