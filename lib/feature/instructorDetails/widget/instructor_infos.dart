import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/data/model/instructor/instructor_profile_data.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class InstructorInfo extends StatelessWidget {
  final InstructorProfileData data;
  const InstructorInfo({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          infoCard(context, "${data.totalCourse}", 'course'.tr),
          infoCard(context, "${data.totalStudent}", 'student'.tr),
          infoCard(context, "${data.followers}", 'follower'.tr),
          Container(
            height: 70,
            width: 75,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.06),
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.network(
                      //Images.logo,
                      data.organization!.logo!,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(Images.placeholder),
                    )),
                const SizedBox(
                  height: 5,
                ),
                Text(data.organization!.name ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: robotoRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.5),
                        fontSize: Dimensions.fontSizeSmall)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(context, String total, String title) {
    return Container(
      height: 70,
      width: 75,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(total,
              style: robotoMedium.copyWith(
                  color: Get.isDarkMode
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          Text(title,
              style: robotoRegular.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.5),
                  fontSize: Dimensions.fontSizeSmall))
        ],
      ),
    );
  }
}
