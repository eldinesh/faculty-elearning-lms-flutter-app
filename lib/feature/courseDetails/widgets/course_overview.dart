import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../../data/model/course_detail/data.dart';

class CourseOverView extends StatelessWidget {
  final CourseDetailData data;
  const CourseOverView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title ?? "",
              style: robotoSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault)),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          data.shortDescription!.isNotEmpty
              ? Text(data.shortDescription ?? "")
              : const SizedBox(),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Html(
            data: data.description ?? "",
            style: {
              "p": Style(
                fontSize: FontSize.medium,
              ),
            },
          ),
        ],
      ),
    );
  }
}
