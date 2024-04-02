import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/coupon_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../data/model/coupon_list/coupon.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'coupon'.tr,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color!,
      ),
      body: GetBuilder<CouponController>(
          initState: (state) => Get.put(CouponController()).getCouponList(),
          builder: (controller) {
            return controller.isCouponListLoading == true &&
                    controller.couponList == null
                ? const LoadingIndicator()
                : mainUI(context, controller.couponList!.data!.coupons!);
          }),
    );
  }

  Column mainUI(BuildContext context, List<Coupon> list) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Images.placeholder,
            fit: BoxFit.fitWidth,
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return couponItem(index, context, list[index]);
              }),
        ),
      ],
    );
  }

  Padding couponItem(int index, BuildContext context, Coupon coupon) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSizeDefault,
        right: Dimensions.paddingSizeDefault,
        bottom: Dimensions.paddingSizeExtraSmall,
        top: index != 0
            ? Dimensions.paddingSizeExtraSmall
            : Dimensions.paddingSizeDefault,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColorLight, width: 1),
          color: Colors.white,
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Image.network(
                    coupon.image ?? '',
                    height: 60,
                    width: 60,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.placeholder,
                      height: 60,
                      width: 60,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          coupon.code ?? '',
                          style: robotoMedium.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color!,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        Text(
                          coupon.discountType == "flat"
                              ? "\$${coupon.discount.toString()}"
                              : "${coupon.discount.toString()}%",
                          style: robotoMedium.copyWith(
                              color: Colors.red,
                              fontSize: Dimensions.fontSizeSemiSmall),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeRadius,
                    ),
                    Text(
                      coupon.title ?? '',
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeExtraSmall),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeRadius,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Ended: ${coupon.endDate}",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.6),
                                fontSize: Dimensions.fontSizeExtraSmall)),
                        InkWell(
                          onTap: () => Get.find<CouponController>()
                              .copyCodeToClipBoard(coupon.code.toString()),
                          child: Text('copy'.tr,
                              style: robotoSemiBold.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeExtraSmall)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
