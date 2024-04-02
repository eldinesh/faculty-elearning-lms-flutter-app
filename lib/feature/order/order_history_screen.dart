import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/download_controller.dart';
import 'package:lms_user_app/controller/order_controller.dart';
import 'package:lms_user_app/data/model/order/order_history_list/order_history.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'order_history'.tr,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color!,
      ),
      body: GetBuilder<OrderController>(
          initState: (state) =>
              Get.put(OrderController()).getOrderHistory("course"),
          builder: (controller) {
            return controller.isLoadingOrderHistory == true
                ? const LoadingIndicator()
                : mainUI(controller);
          }),
    );
  }

  Widget mainUI(OrderController controller) {
    return RefreshIndicator(
      onRefresh: () => Get.put(OrderController()).getOrderHistory("course"),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.orderHistoryList.length,
          itemBuilder: (context, index) {
            OrderHistory history = controller.orderHistoryList[index];
            return historyItem(context, index, history);
          }),
    );
  }

  Widget historyItem(BuildContext context, int index, OrderHistory history) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColorLight,
            width: 1,
          ),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index == 0)
              const SizedBox(height: Dimensions.paddingSizeDefault),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    history.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: Dimensions.fontSizeSmall),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.put(DownloaderController()).downloadFile(history);
                  },
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.radiusSmall)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.radiusSmall, vertical: 3),
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.download),
                        const SizedBox(width: 8),
                        Text('invoice'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.6),
                                fontSize: Dimensions.fontSizeSmall)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Text(
              "Payment by ${history.paymentType}",
              style: robotoRegular.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                  fontSize: Dimensions.fontSizeSmall),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${history.amount}",
                    style: robotoSemiBold.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                        fontSize: Dimensions.fontSizeSmall)),
                Text(history.createdAt ?? '',
                    style: robotoRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                        fontSize: Dimensions.fontSizeExtraSmall)),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ],
        ),
      ),
    );
  }
}
