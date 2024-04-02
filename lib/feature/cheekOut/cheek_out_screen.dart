import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/controller/cart_controller.dart';
import 'package:lms_user_app/feature/cheekOut/widget/payment_method.dart';
import 'package:lms_user_app/feature/cheekOut/widget/success_message.dart';
import 'package:lms_user_app/utils/dimensions.dart';

class CheekOutScreen extends StatelessWidget {
  const CheekOutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cheek Out'.tr,
      ),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                //TODO: change below
                //return const CartItem(isCoupon: false);
                return Container();
              });
        },
      ),
      bottomNavigationBar: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: remove comment
            //const CalculatePayment(),
            const PaymentMethod(),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: CustomButton(
                onPressed: () {
                  Get.dialog(const SuccessMessage());
                },
                buttonText: 'complete_payment'.tr,
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            )
          ],
        ),
      ),
    );
  }
}
