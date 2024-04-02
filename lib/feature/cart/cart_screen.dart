import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/cart_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/feature/cart/widget/calculate_payment.dart';
import 'package:lms_user_app/feature/cart/widget/cart_item.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'cart_item'.tr,
      ),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          return cartController.isCartDataLoading == true
              ? const LoadingIndicator()
              : cartController.cartList.isEmpty
              ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Images.emptyCart,scale: 3,),
                  Text(
                    'empty_cart'.tr,
                    style: robotoSemiBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                  Text('you_have_not_added_anything'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Theme.of(Get.context!).textTheme.bodySmall!.color!.withOpacity(.7),
                    ),),
                ],
              ))
              : ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: cartController.cartList.length,
                  itemBuilder: (context, index) {
                    return CartItem(
                      cart: cartController.cartList[index],
                      index: index,
                    );
                  });
        },  
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (controller) {
        return controller.isCartDataLoading == true
            ? const LoadingIndicator()
            : controller.cartList.isEmpty
            ? const SizedBox()
            : SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CalculatePayment(calculation: controller.calculations),
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      child: CustomButton(
                        onPressed: () {
                          // Get.toNamed(RouteHelper.getCheekOutScreen());
                          Get.toNamed(RouteHelper.getPaymentScreen());
                        },
                        buttonText: 'go_to_payment'.tr,
                      ),
                    ),
                    const SizedBox(
                      height: Dimensions.paddingSizeDefault,
                    )
                  ],
                ),
              );
      }),
    );
  }
}
