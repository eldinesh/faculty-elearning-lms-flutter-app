import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:lms_user_app/data/model/common/organization.dart';

class OrganizationWidget extends StatelessWidget {
  final Organization organization;
  const OrganizationWidget({Key? key, required this.organization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('organization'.tr,
              style: robotoSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06),
                  width: 1),
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.radiusSmall)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.radiusSmall)),
                        child: CustomImage(
                          width: 80,
                          height: 80,
                          image: organization.logo ?? "",
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeSmall,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(RouteHelper.getOrganizationScreen(),
                                arguments: organization.id);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                organization.name ?? "",
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeDefault,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!),
                              ),
                              const SizedBox(
                                height: Dimensions.paddingSizeSmall,
                              ),
                              Text(
                                organization.tagline ?? "",
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.6)
                                        .withOpacity(0.5)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
