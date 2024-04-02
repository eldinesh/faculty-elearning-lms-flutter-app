import 'package:flutter/material.dart';
import 'package:lms_user_app/controller/instructor_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';

import '../../../components/course_view_verticle.dart';
import '../../../components/paginated_list_view.dart';

class CourseTab extends StatefulWidget {
  final InstructorController controller;
  final int id;
  const CourseTab({super.key, required this.controller, required this.id});

  @override
  State<CourseTab> createState() => _CourseTabState();
}

class _CourseTabState extends State<CourseTab> {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return PaginatedListView(
      scrollController: scrollController,
      totalSize: 10,
      offset: 1,
      onPaginate: (int offset) {
        printLog("-----time to paginate:");
        //widget.controller.paginateCourseList(widget.id);
      },
      itemView: ServiceViewVertical(
        isScrollable: false,
        service: widget.controller.instructorCourseList,
      ),
    );
  }
}
