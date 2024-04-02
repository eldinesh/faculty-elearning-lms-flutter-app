import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/data/model/explore.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:lms_user_app/feature/explore/widgets/explore_course_widget.dart';
import '../../../data/model/common/course.dart';

class FreeCourses extends StatelessWidget {
  final Explore explore;
  const FreeCourses({Key? key, required this.explore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Course> courses = explore.data!.freeCourses!;
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'free_course'.tr,
            style:
                robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
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
                  padding: const EdgeInsets.only(
                      right: Dimensions.paddingSizeDefault),
                  child: ExploreCourseWidget(
                    course: courses.elementAt(index),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
