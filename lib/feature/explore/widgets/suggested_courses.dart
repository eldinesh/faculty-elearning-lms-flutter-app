import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/data/model/explore.dart';
import 'package:lms_user_app/feature/explore/widgets/explore_course_widget.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../../data/model/common/course.dart';


class SuggestedCourses extends StatelessWidget {
  final Explore explore;
  const SuggestedCourses({Key? key, required this.explore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Course> courses = explore.data!.suggestedCourses!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text(
            'suggested_courses'.tr,
            style: robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        SizedBox(
          height: 197,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: Dimensions.paddingSizeDefault,
                  left: index==0? Dimensions.paddingSizeDefault:0
                ),
                child: ExploreCourseWidget(
                  course: courses.elementAt(index),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
