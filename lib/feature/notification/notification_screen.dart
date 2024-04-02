import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/notification_controller.dart';
import 'package:lms_user_app/data/model/notification_model.dart'
    as notification;
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../utils/images.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'notification'.tr,
          centerTitle: false,
          bgColor: Theme.of(context).cardColor,
          titleColor: Theme.of(context).textTheme.bodyLarge!.color!,
        ),
        body: GetBuilder<NotificationController>(
            initState: (state) =>
                Get.find<NotificationController>().getNotificationList(),
            builder: (controller) {
              return controller.isLoading
                  ? const LoadingIndicator()
                  : notificationSection(context, controller);
            }));
  }

  notificationSection(BuildContext context, NotificationController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: controller.isLoading
          ? const LoadingIndicator()
          : controller.notificationList.isEmpty
              ? noDataWidget()
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.notificationList.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      item(context, controller.notificationList[index]),
                ),
    );
  }

  Widget item(BuildContext context, notification.Notification notification) {
    return ListTile(
      // leading: generateLeading(NotificationType.accepted),
      leading: SvgPicture.asset(Images.notificationWithBg),
      title: Text(notification.title ?? ''),
      titleTextStyle: robotoRegular,
      trailing: Text(
        notification.date ?? '',
        style: robotoRegular.copyWith(
            fontSize: Dimensions.fontSizeSmall,
            color: Theme.of(context)
                .textTheme
                .titleSmall!
                .color!
                .withOpacity(0.6)),
      ),
    );
  }

  Widget generateLeading(NotificationType type) {
    switch (type) {
      case NotificationType.accepted:
        return CircleWithIcon(
          color: Colors.green,
          icon: Images.acceptedNotification,
        );
      case NotificationType.cancled:
        return CircleWithIcon(
          color: Colors.red,
          icon: Images.cancelNotification,
        );
      case NotificationType.discount:
        return CircleWithIcon(
          color: Colors.amber,
          icon: Images.discountNotification,
        );
      case NotificationType.offer:
        return CircleWithIcon(
          color: Colors.yellowAccent,
          icon: Images.voucherNotification,
        );
    }
  }

  Widget noDataWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(Images.emptyNotification,scale: 3,),
          const SizedBox(height: Dimensions.paddingSizeSmall,),
          Text(
            'no_notifications_yet'.tr,
            style: robotoSemiBold.copyWith(
              fontSize: Dimensions.fontSizeLarge,
            ),),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
          Text('you_have_no_notifications'.tr,
            style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(Get.context!).textTheme.bodySmall!.color!.withOpacity(.7),
            ),),
        ],
      ),
    );
  }
}

enum NotificationType { accepted, cancled, discount, offer }

class CircleWithIcon extends StatelessWidget {
  final Color color;
  final String icon;
  const CircleWithIcon({super.key, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          SvgPicture.asset(
            icon,
            height: 10,
            width: 10,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
