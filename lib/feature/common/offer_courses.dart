import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/feature/explore/widgets/explore_course_widget.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import '../../data/model/common/course.dart';

class OfferCourses extends StatelessWidget {
  final List<Course> offeredCourses;
  const OfferCourses({Key? key, required this.offeredCourses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleView(
            title: 'offer_courses'.tr,
            isViewAllEnabled:false,
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        SizedBox(
          height: 197,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offeredCourses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: Dimensions.paddingSizeDefault,
                    left: index == 0 ? Dimensions.paddingSizeDefault : 0),
                child: ExploreCourseWidget(
                  course: offeredCourses.elementAt(index),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
