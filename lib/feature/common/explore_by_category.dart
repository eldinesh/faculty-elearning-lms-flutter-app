import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../data/model/common/category.dart';

class ExploreByCategoryWidget extends StatelessWidget {
  final String title;
  final List<Category> categoryList;
  const ExploreByCategoryWidget(
      {Key? key, required this.categoryList, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        TitleView(
          title: title.tr,
          onViewAllClicked: () => Get.toNamed(RouteHelper.getCategoryScreen()),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        SizedBox(
          height: 90,
          child: ListView.builder(
              itemCount: categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return item(index, context);
              }),
        )
      ],
    );
  }

  InkWell item(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.getAllCourseScreen(
            categoryList.elementAt(index).id.toString(),
            categoryList.elementAt(index).title ?? ''));
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: index == 0 ? Dimensions.paddingSizeDefault : 0,
            right: Dimensions.paddingSizeExtraSmall),
        child: Container(
          height: 90,
          width: 70,
          decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.06),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                CustomImage(image: categoryList.elementAt(index).icon!),
                const SizedBox(height: Dimensions.paddingSizeExtraSmall,),
                Text(
                  categoryList.elementAt(index).title ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).dividerColor,
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.normal),
                ),
                Text(
                  "${categoryList.elementAt(index).totalCourses} ${'courses'.tr}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: robotoRegular.copyWith(
                      color: Theme.of(context).dividerColor,
                      fontSize: Dimensions.fontSizeExtraSmall,
                      fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
