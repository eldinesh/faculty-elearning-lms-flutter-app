import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

enum NoDataType {
  cart, notification, booking, coupon, others, home, offers, address,search, course,inbox, category, certificate
}

class NoDataScreen extends StatelessWidget {
  final NoDataType? type;
  final String? text;
  final bool isShowHomePage;
  const NoDataScreen({super.key, required this.text, this.type,  this.isShowHomePage = true, });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(type != NoDataType.certificate)
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.03),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset((type == NoDataType.cart || type == NoDataType.booking) ? Images.cart:
            type == NoDataType.notification ? Images.notification:
            type == NoDataType.search ? Images.notification:
            type == NoDataType.inbox ? Images.chat:
            type == NoDataType.offers ? Images.search:Images.search,
              width: type == NoDataType.coupon ? 50.0:MediaQuery.of(context).size.height*0.12 ,
              height:type == NoDataType.coupon ? 50.0: MediaQuery.of(context).size.height*0.12,
              color: Get.isDarkMode && (
                  type == NoDataType.booking ||
                      type == NoDataType.home ||
                      type == NoDataType.course ||
                      type == NoDataType.category ||
                      type == NoDataType.notification
              )? Theme.of(context).primaryColorLight:null,
            ),
          ),
          Text(
            type == NoDataType.cart ? 'your_cart_is_empty'.tr :
            type == NoDataType.booking ? 'sorry_your_order_history_is_Empty'.tr :
            type == NoDataType.notification ? 'empty_notifications'.tr : text!,
            style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(.6),),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.04),
          if(type != NoDataType.category && type != NoDataType.inbox && type != NoDataType.booking && type != NoDataType.course  &&type != NoDataType.search  && type != NoDataType.offers && type != NoDataType.cart  && type != NoDataType.home && type != NoDataType.coupon && isShowHomePage )
            CustomButton(
              height: 40, width: 200,
              buttonText: 'back_to_homepage'.tr,
              onPressed: () => Get.offAllNamed(RouteHelper.getMainRoute('no-data-screen')),
            ),

        ]);
  }
}
