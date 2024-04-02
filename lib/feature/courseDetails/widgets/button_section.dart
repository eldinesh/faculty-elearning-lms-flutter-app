import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/cart_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../../core/helper/route_helper.dart';
import '../../../data/model/course_detail/data.dart';

class ButtonSection extends StatelessWidget {
  final CourseDetailData data;
  const ButtonSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radiusDefault),
              topRight: Radius.circular(Dimensions.radiusDefault)),
          shape: BoxShape.rectangle,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1))
          ]),
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
                          SvgPicture.asset(
                            Images.phone,
                            color: Get.isDarkMode
                                ? Colors.green
                                : Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            data.contactNo!,
                            style: robotoRegular.copyWith(
                                color: Get.isDarkMode
                                    ? Colors.green
                                    : Theme.of(context).primaryColor,
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
                    const SizedBox(width: Dimensions.paddingSizeRadius),
                    Text(
                      data.price == "Free" ? "Free" : "${data.price}",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: Dimensions.fontSizeLarge,
                          fontWeight: FontWeight.bold,
                          decoration: data.isDiscounted == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            // button
            GetBuilder<CartController>(
                //init: CartController(),
                //initState: (state) => Get.put(CartController()).getCartList(),
                builder: (cartController) {
              return cartController.isCartDataLoading == true
                  ? const LoadingIndicator()
                  : CustomButton(
                      onPressed: () {
                        if (cartController
                            .isCartListContainCourseId(data.id!)) {
                          Get.toNamed(RouteHelper.getCartScreen());
                        } else {
                          cartController.addToCart(data.id!, 'course');
                        }
                      },
                      buttonText:
                          cartController.isCartListContainCourseId(data.id!)
                              ? "view_cart".tr
                              : "add_to_cart".tr,
                    );
            }),
            const SizedBox(height: Dimensions.paddingSizeSmall),
          ],
        ),
      ),
    );
  }
}
