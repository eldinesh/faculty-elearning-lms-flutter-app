import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/controller/instructor_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class InstructorTab extends StatelessWidget {
  final int id;
  const InstructorTab({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GetBuilder<InstructorController>(builder: (controller) {
      return Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return studentItem(index, context, width);
            }),
      );
    });
  }

  Padding studentItem(int index, BuildContext context, double width) {
    return Padding(
      padding: EdgeInsets.only(
        top: index == 0
            ? Dimensions.paddingSizeRadius
            : Dimensions.paddingSizeExtraSmall,
        left: Dimensions.paddingSizeExtraSmall,
        right: Dimensions.paddingSizeExtraSmall,
        bottom: Dimensions.paddingSizeExtraSmall,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06),
            ),
            //top: BorderSide(color: Theme.of(context).primaryColorLight),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: Dimensions.paddingSizeSmall,
            left: Dimensions.paddingSizeSmall,
            right: Dimensions.paddingSizeSmall,
            bottom: Dimensions.paddingSizeLarge,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Dimensions.radiusExtraMoreLarge),
                      ),
                      child: CustomImage(
                        image: Images.logo,
                        height: 70,
                        width: 70,
                      )),
                  const SizedBox(
                    width: Dimensions.paddingSizeSmall,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width / 1.9,
                          child: Text(
                            "Leslie Alexander $index",
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),
                        Text(
                          "Student",
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeSmall,
                  ),
                  SizedBox(
                      height: 18,
                      width: 18,
                      child: SvgPicture.asset(
                        Images.chat,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
