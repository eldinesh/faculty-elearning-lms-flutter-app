import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../data/model/common/instructor.dart';

class CourseInstructor extends StatelessWidget {
  final String title;
  final List<Instructor> instructors;
  const CourseInstructor(
      {Key? key, required this.instructors, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleView(title: title.tr, isViewAllEnabled: false),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        SizedBox(
          height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: instructors.length,
              itemBuilder: (context, index) {
                Instructor instructor = instructors.elementAt(index);
                return Container(
                  width: 255,
                  margin: const EdgeInsets.only(
                      left: Dimensions.paddingSizeDefault),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.06),
                    ),
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInstructorDetails(),
                          arguments: instructor.id);
                    },
                    child: Row(
                      children: [
                        const SizedBox(width: Dimensions.paddingSizeSmall,),
                        ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                            child: CustomImage(image: instructor.image!,height: 50,width: 50,)),
                        const SizedBox(width: Dimensions.paddingSizeSmall,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              instructor.name ?? "",
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            Text(instructor.instructor ?? "",
                                style: robotoRegular.copyWith(
                                    color: Get.isDarkMode
                                        ? Colors.green
                                        : Theme.of(context)
                                            .colorScheme
                                            .primary,
                                    fontSize:
                                    Dimensions.fontSizeExtraSmall)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
