import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/course_view_verticle.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/components/paginated_list_view.dart';
import 'package:lms_user_app/controller/instructor_controller.dart';

import '../../components/custom_image.dart';
import '../../data/model/instructor/instructor_student_list/student.dart';
import '../../utils/dimensions.dart';
import '../../utils/images.dart';
import '../../utils/styles.dart';
import 'widget/follow_message.dart';
import 'widget/instructor_app_bar_body.dart';
import 'widget/instructor_infos.dart';

class InstructorDetailScreen extends StatefulWidget {
  const InstructorDetailScreen({super.key});

  @override
  State<InstructorDetailScreen> createState() => _InstructorDetailScreenState();
}

class _InstructorDetailScreenState extends State<InstructorDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isAppBarExpanded = true;
  TabController? _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    Get.find<InstructorController>().getInstructorProfile(Get.arguments);
    Get.find<InstructorController>().getInstructorCourseList(Get.arguments);
    Get.find<InstructorController>().getInstructorsStudentList(Get.arguments);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 300 && _isAppBarExpanded) {
      setState(() {
        _isAppBarExpanded = false;
      });
    } else if (_scrollController.offset <= 300 && !_isAppBarExpanded) {
      setState(() {
        _isAppBarExpanded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InstructorController>(builder: (controller) {
        return controller.isLoading
            ? const LoadingIndicator()
            : mainUI(context, controller);
      }),
    );
  }

  Widget mainUI(BuildContext context, InstructorController controller) {
    return NestedScrollView(
      controller: _scrollController,
      floatHeaderSlivers: false,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          customAppBar(context, controller),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: Delegate(
                height: 40,
                widget: Container(
                  color: Theme.of(context).cardColor,
                  child: TabBar(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeDefault),
                    indicatorWeight: 1,
                    controller: _tabController,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor:
                        Theme.of(context).textTheme.bodyLarge!.color!,
                    unselectedLabelStyle: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeSmall),
                    labelStyle: robotoBold.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                    tabs: [
                      Tab(text: 'course'.toUpperCase().tr),
                      Tab(text: 'student'.toUpperCase().tr),
                    ],
                  ),
                )),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: const [
          CourseTab(),
          StudentTab(
            instructorId: 2,
          ),
        ],
      ),
    );
  }

  SliverAppBar customAppBar(
      BuildContext context, InstructorController controller) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).textTheme.bodyLarge!.color,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Theme.of(context).cardColor,
      title: _isAppBarExpanded
          ? null
          : Text(
              // "instructorDetails".tr,
              controller.instructorProfile.data?.name ?? '',
              textAlign: TextAlign.start,
              style: robotoSemiBold.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeDefault),
            ),

      //backgroundColor: Theme.of(context).cardColor,
      expandedHeight: 380.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: Dimensions.paddingSizeLarge),
              InstructorAppBarBody(profileData: controller.instructorProfile.data!),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              FollowMessage(id: Get.arguments),
              const SizedBox(height: Dimensions.paddingSizeExtraLarge),
              InstructorInfo(data: controller.instructorProfile.data!),
              const SizedBox(height: Dimensions.paddingSizeDefault),
            ],
          ),
        ),
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final double height;
  final Widget widget;

  Delegate({required this.height, required this.widget});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class CourseTab extends StatelessWidget {
  const CourseTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return GetBuilder<InstructorController>(
      builder: (instructorController) {
        return PaginatedListView(
          scrollController: scrollController,
          totalSize: 10,
          offset: 1,
          onPaginate: (int offset) {},
          itemView: ServiceViewVertical(
            isScrollable: false,
            service: instructorController.instructorCourseList,
          ),
        );
      },
    );
  }
}

class StudentTab extends StatefulWidget {
  final int instructorId;
  const StudentTab({super.key, required this.instructorId});

  @override
  State<StudentTab> createState() => _StudentTabState();
}

class _StudentTabState extends State<StudentTab> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstructorController>(
      builder: (controller) {
        return ListView.builder(
          controller: controller.studentListScrollController,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            if (index == controller.instructorStudentList.length - 1 &&
                controller.isStudentListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return studentItem(
                  controller.instructorStudentList[index], index, context);
            }
          },
          itemCount: controller.instructorStudentList.length,
        );
      },
    );
  }

  Padding studentItem(Student student, int index, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.radiusExtraMoreLarge),
                    ),
                    child: CustomImage(
                      image: student.image ?? '',
                      placeholder: Images.placeholder,
                      height: 70,
                      width: 70,
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
                        SizedBox(
                          width: width / 1.9,
                          child: Text(
                            student.name ?? '',
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault),
                          ),
                        ),
                        const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall,
                        ),
                        Text(
                          'student'.tr,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
