/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/organization_controller.dart';
import '../../../core/helper/responsive_helper.dart';
import '../../../utils/dimensions.dart';
import '../../common/course_widget.dart';

class CourseTab extends StatelessWidget {
  final int id;
  const CourseTab({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrganizationController>(
      builder: (controller) {
        return controller.courseList.isEmpty
            ? const LoadingIndicator()
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    controller.getCourseList(id);
                  }
                  return false;
                },
                child: GridView.builder(
                  controller: controller.courseListScrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: Dimensions.paddingSizeDefault,
                    mainAxisSpacing: Dimensions.paddingSizeDefault,
                    childAspectRatio:
                        ResponsiveHelper.isTab(context) ? .9 : .63,
                    mainAxisExtent:
                        ResponsiveHelper.isMobile(context) ? 225 : 260,
                    crossAxisCount: ResponsiveHelper.isMobile(context)
                        ? 2
                        : ResponsiveHelper.isTab(context)
                            ? 3
                            : 5,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == controller.courseList.length - 1 &&
                        controller.isCourseListLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return CourseWidget(course: controller.courseList[index]);
                    }
                  },
                  itemCount: controller.courseList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                ),
              );
      },
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/course_view_verticle.dart';
import 'package:lms_user_app/components/paginated_list_view.dart';
import 'package:lms_user_app/controller/organization_controller.dart';

class CourseTab extends StatelessWidget {
  const CourseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return  GetBuilder<OrganizationController>(
      builder: (organizationController){
        return PaginatedListView(
          scrollController: scrollController,
          totalSize: 10,
          offset: 1,
          onPaginate: (int offset) {

          },
          itemView: ServiceViewVertical(
            isScrollable:false,
            service: organizationController.courseList,),
        );
      },
    );
  }
}