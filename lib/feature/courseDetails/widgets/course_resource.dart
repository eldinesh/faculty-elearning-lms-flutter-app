import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../data/model/course_detail/resources.dart';

class CourseResource extends StatelessWidget {
  final Resources resource;
  const CourseResource({Key? key, required this.resource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Text(
            'course_resource'.tr,
            style:
                robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
            children: [
              // if (resource.isDocAvailable == true)
              // featureCade(context, Images.pdfFormat, "PDF Format"),
              if (resource.isDocAvailable == true)
                featureCade(context, Images.document, "Doc Format"),
              if (resource.isVideoAvailable == true)
                featureCade(context, Images.polygon, "Video File"),
              if (resource.isAudioAvailable == true)
                featureCade(context, Images.audioFile, "Audio File"),
            ],
          ),
        )
      ],
    );
  }

  Widget featureCade(context, String icon, String title) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width / 2 - 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              //color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusSmall),
                bottomLeft: Radius.circular(Dimensions.radiusSmall),
              ),
            ),
            child: Center(
              child: SvgPicture.asset(icon),
            ),
          ),
          const SizedBox(
            width: Dimensions.paddingSizeSmall,
          ),
          Text(
            title,
            style: robotoRegular.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.5),
                fontSize: Dimensions.fontSizeSmall),
          )
        ],
      ),
    );
  }
}
