import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/my_course_controller.dart';
import 'package:lms_user_app/feature/common/my_course_widget_item.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';

import '../../../utils/styles.dart';

class PurchaseCourseList extends StatefulWidget {
  const PurchaseCourseList({Key? key}) : super(key: key);

  @override
  State<PurchaseCourseList> createState() => _PurchaseCourseListState();
}

class _PurchaseCourseListState extends State<PurchaseCourseList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        Get.find<MyCourseController>().paginatePurchaseCourse();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyCourseController>(
        initState: (state) => Get.find<MyCourseController>().getMyCourseList(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: controller.isMyCourseLoading
                ? const LoadingIndicator()
                : controller.myCourseList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(Images.emptyCourse,scale: 3,),
                            Text('you_dont_have_any_purchased_course'.tr,
                                style: robotoRegular),
                          ],
                        ))
                    : mainUI(controller),
          );
        });
  }

  Widget mainUI(MyCourseController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.getMyCourseList(),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return MyCourseWidgetItem(course: controller.myCourseList[index]);
              },
                childCount: controller.myCourseList.length),),
                const SliverToBoxAdapter(
                  child: SizedBox(height: Dimensions.paddingSizeDefault),
                ),

          if (controller.isMyCourseLoadingMore == true)
            const SliverToBoxAdapter(
              child: LoadingIndicator(),
            )
        ],
      ),
    );
  }
}
