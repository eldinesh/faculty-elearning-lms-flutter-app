import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/cart_controller.dart';
import 'package:lms_user_app/data/model/book_detail/data.dart';

import '../../../components/custom_button.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class BookCartSection extends StatelessWidget {
  final BookDetailData data;
  const BookCartSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 122,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                data.contactNo!.isEmpty
                    ? const SizedBox()
                    : Row(
                        children: [
                          Text(
                            "${'contact'.tr}:",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!,
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall,
                          ),
                          SvgPicture.asset(Images.phone),
                          const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            data.contactNo!,
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                        ],
                      ),
                Row(
                  children: [
                    if (data.isDiscounted == true)
                      Text(
                        "\$${data.discountedPrice}",
                        style: robotoSemiBold.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color!,
                            fontSize: Dimensions.fontSizeLarge),
                      ),
                    const SizedBox(
                      width: Dimensions.paddingSizeRadius,
                    ),
                    Text(
                      data.price == "Free" ? "Free" : "\$${data.price}",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: Dimensions.fontSizeSmall,
                          decoration: data.isDiscounted == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            GetBuilder<CartController>(
                init: CartController(),
                builder: (controller) {
                  return controller.isCartDataLoading
                      ? const LoadingIndicator()
                      : CustomButton(
                          onPressed: () {
                            controller.addToCart(data.id!, "book");
                            //Get.toNamed(RouteHelper.getCartScreen());
                          },
                          buttonText: "add_to_cart".tr,
                        );
                }),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ],
        ),
      ),
    );
  }
}
