import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../feature/common/course_widget.dart';

class CourseHorizontal extends StatelessWidget {
  final String title;
  const CourseHorizontal({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text(title.tr,style: robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault,),
        SizedBox(
          height: 197,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context,index){
              return Padding(
                padding: EdgeInsets.only(
                  right: Dimensions.paddingSizeDefault,
                  left: index==0? Dimensions.paddingSizeDefault:0,
                ),
                child: const CourseWidget(),
              );
            },
          ),
        )
      ],
    );
  }
}
