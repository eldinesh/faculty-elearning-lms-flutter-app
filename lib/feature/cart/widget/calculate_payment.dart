import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../data/model/cart_list/calculations.dart';

class CalculatePayment extends StatelessWidget {
  final Calculations? calculation;
  const CalculatePayment({Key? key, required this.calculation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Container(
          // height: 96,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06)),
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.radiusSmall))),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'sub_total'.tr,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    Text(
                      "${calculation?.subTotal}",
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'discount'.tr,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    Text(
                      "${calculation?.discount}",
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ],
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'coupon'.tr,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    Text(
                      "${calculation?.couponDiscount}",
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'total'.tr,
                      style: robotoSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    Text(
                      "${calculation?.totalPayable}",
                      style: robotoSemiBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
