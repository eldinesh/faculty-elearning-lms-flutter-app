import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../../data/model/common/my_course.dart';

class MyCourseWidget extends StatelessWidget {
  final List<MyCourse>? myCourseList;
  final Function()? callback;

  const MyCourseWidget({Key? key, this.myCourseList, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return myCourseList != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleView(
                title: 'my_courses'.tr,
                onViewAllClicked: callback,

              ),
              const SizedBox(
                height: Dimensions.paddingSizeDefault,
              ),
              SizedBox(
                height: 112,
                child: ListView.builder(
                    itemCount: myCourseList?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      MyCourse myCourse = myCourseList![index];
                      //return MyCourseWidgetItem(course: myCourse);
                      return myCourseItem(index, context, myCourse);
                    }),
              )
            ],
          )
        : const SizedBox();
  }

  Widget myCourseItem(int index, BuildContext context, MyCourse myCourse) {
    return Padding(
      padding: EdgeInsets.only(
          right: Dimensions.paddingSizeDefault,
          left: index == 0 ? Dimensions.paddingSizeDefault : 0),
      child: InkWell(
        onTap: () =>
            Get.toNamed(RouteHelper.getLearningScreen(
                myCourse.id.toString(),
                myCourse.title!
            )),
        radius: 6,
        child: Container(
          width: MediaQuery.of(context).size.width / 1.3,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06)),
              borderRadius: const BorderRadius.all(Radius.circular(6))),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                      child: CustomImage(
                        width: 60,
                        height: 60,
                        image: myCourse.thumbnail ?? "",
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeSmall,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myCourse.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                          const SizedBox(
                            height: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            "${myCourse.completedLessons} Lesson / ${myCourse.totalLessons} Lesson",
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeExtraSmall,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.5)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${myCourse.completedPercentage}",
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Get.isDarkMode
                            ? Colors.green
                            : Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  height: Dimensions.paddingSizeExtraSmall
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: calculatePercentage(
                        myCourse.completedPercentage ?? "0%"),
                    valueColor: AlwaysStoppedAnimation<Color>(Get.isDarkMode
                        ? Colors.green.withOpacity(.5)
                        : Theme.of(context).primaryColor.withOpacity(.5)),
                    backgroundColor: Get.isDarkMode
                        ? Colors.green.withOpacity(.1)
                        : Theme.of(context).primaryColor.withOpacity(.1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculatePercentage(String percentage) {
    return double.parse(percentage.replaceAll('%', '')) / 100;
  }
}
