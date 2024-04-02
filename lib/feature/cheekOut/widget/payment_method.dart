import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('payment_get_way'.tr,
            style: robotoSemiBold.copyWith(
                fontSize: Dimensions.fontSizeDefault),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          paymentCart(context,Images.bkashDemo,"bKash"),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          paymentCart(context,Images.nagadDemo,"Nagad"),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          paymentCart(context,Images.googlePayDemo,"Google Pay"),
        ],
      ),
    );
  }
  Widget paymentCart(context,String icon,String title){
    return  Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06)),
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall))
          ),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(icon,height: 22,),
                    const SizedBox(width: Dimensions.paddingSizeDefault,),
                    Text(
                      title,
                        style: robotoSemiBold.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).textTheme.bodyLarge!.color!
                        ),
                    ),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios,size: Dimensions.radiusLarge,)
              ],
            ),
          ),
        )
      ],
    );
  }
}
