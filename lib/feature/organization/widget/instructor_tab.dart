import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/organization_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/common/instructor.dart';

import '../../../components/custom_image.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class InstructorTab extends StatelessWidget {
  final int organizationId;
  const InstructorTab({super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizationController>(builder: (controller) {
      return NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            controller.getInstructorList(organizationId);
          }
          return false;
        },
        child: ListView.builder(
          controller: controller.instructorScrollController,
          itemCount: controller.instructorList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == controller.instructorList.length - 1 &&
                controller.isInstructorListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return instructorItem(controller.instructorList[index], context);
            }
          },
        ),
      );
    });
  }

  Widget instructorItem(Instructor instructor, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () =>
            Get.toNamed(RouteHelper.instructorDetails, arguments: instructor.id),
        child: SizedBox(
          height: 76,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.radiusExtraMoreLarge),
                ),
                child: CustomImage(
                  image: instructor.image ?? '',
                  placeholder: Images.placeholder,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: Dimensions.paddingSizeDefault,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(instructor.name ?? '',
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault)),
                  Text(
                    instructor.instructor ?? '',
                    style: robotoMedium.copyWith(
                        color: Get.isDarkMode
                            ? Colors.green
                            : Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeExtraSmall),
                  ),
                ],
              ),

              const Divider(height: 1)
            ],
          ),
        ),
      ),
    );
  }
}
