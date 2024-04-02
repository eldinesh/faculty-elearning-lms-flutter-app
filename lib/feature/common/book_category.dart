import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../data/model/common/category.dart';

class BookCategoryWidget extends StatelessWidget {
  final String title;
  final List<Category> categoryList;
  const BookCategoryWidget(
      {Key? key, required this.categoryList, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleView(title: title.tr),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        SizedBox(
          height: 90,
          child: ListView.builder(
              itemCount: categoryList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Dimensions.paddingSizeDefault : 0,
                    right: Dimensions.paddingSizeExtraSmall,
                  ),
                  child: InkWell(
                    onTap: () {},
                    radius: 6,
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.06),
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6))),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(Images.categoryOne),
                            const SizedBox(
                              height: Dimensions.paddingSizeDefault,
                            ),
                            Text(
                              categoryList.elementAt(index).title ?? "",
                             
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontWeight: FontWeight.normal,
                                  fontSize: Dimensions.fontSizeSmall),
                            ),
                            Text(
                              "${categoryList.elementAt(index).totalCourses ?? 0} ${'course'.tr}",
                              style: robotoRegular.copyWith(
                                  color: const Color(0xff999999),
                                  fontSize: Dimensions.fontSizeExtraSmall),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
