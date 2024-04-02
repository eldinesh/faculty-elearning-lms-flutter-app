import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/course_view_verticle.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/paginated_list_view.dart';
import 'package:lms_user_app/controller/course_controller.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/feature/root/view/no_data_screen.dart';

class AllCourseScreen extends StatefulWidget {
  final String? title;
  final String? categoryID;
  const AllCourseScreen(
      {Key? key, required this.title, required this.categoryID})
      : super(key: key);

  @override
  State<AllCourseScreen> createState() => _AllCourseScreenState();
}

class _AllCourseScreenState extends State<AllCourseScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: GetBuilder<CourseController>(
        initState: (state) async {
          await Get.find<CourseController>()
              .getCategoryBasedCourseList(1, widget.categoryID!, true);
        },
        builder: (courseController) {
          List<Course>? courseList = courseController.courseList;

          if (courseList == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return courseList.isNotEmpty
                ? PaginatedListView(
                    scrollController: scrollController,
                    totalSize: 10,
                    offset: 1,
                    onPaginate: (int offset) {},
                    itemView: ServiceViewVertical(
                      isScrollable: true,
                      service: courseList,
                    ),
                  )
                : NoDataScreen(text: 'no_course_found'.tr);
          }
        },
      ),
    );
  }
}
