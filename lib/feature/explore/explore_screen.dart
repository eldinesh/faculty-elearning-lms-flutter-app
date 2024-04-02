import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/explore_controller.dart';
import 'package:lms_user_app/feature/common/explore_by_category.dart';
import 'package:lms_user_app/feature/common/featured_courses_widget.dart';
import 'package:lms_user_app/feature/common/offer_courses.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import '../common/course_instructor.dart';
import 'widgets/free_course.dart';
import 'widgets/suggested_courses.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   isBackButtonExist: false,
      //   title: 'explore_course'.tr,
      //   bgColor: Theme.of(context).primaryColor,
      //   centerTitle: false,
      // ),
      body: SafeArea(
        child: GetBuilder<ExploreController>(builder: (controller) {
          return controller.isLoading
              ? const LoadingIndicator()
              : mainUI(context, controller);
        }),
      ),
    );
  }

  Widget mainUI(BuildContext context, ExploreController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.getExploreData(),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: CustomScrollView(
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      SuggestedCourses(explore: controller.explore),
                      SizedBox(
                          height: controller
                                  .explore.data!.suggestedCourses!.isNotEmpty
                              ? Dimensions.paddingSizeExtraLarge
                              : 0),
                      if (controller.explore.data!.courseCategories!.isNotEmpty)
                        ExploreByCategoryWidget(
                            title: 'explore_by_category',
                            categoryList:
                                controller.explore.data!.courseCategories!),
                      SizedBox(
                          height: controller
                                  .explore.data!.courseCategories!.isNotEmpty
                              ? Dimensions.paddingSizeExtraLarge
                              : 0),
                      if (controller.explore.data!.featuredCourses!.isNotEmpty)
                        FeaturedCourse(
                          courseList: controller.explore.data!.featuredCourses!,
                        ),
                      SizedBox(
                          height: controller
                                  .explore.data!.featuredCourses!.isNotEmpty
                              ? Dimensions.paddingSizeExtraLarge
                              : 0),
                      if (controller.explore.data!.freeCourses!.isNotEmpty)
                        FreeCourses(
                          explore: controller.explore,
                        ),
                      SizedBox(
                          height:
                              controller.explore.data!.freeCourses!.isNotEmpty
                                  ? Dimensions.paddingSizeExtraLarge
                                  : 0),
                      if (controller.explore.data!.instructors!.isNotEmpty)
                        CourseInstructor(
                            title: 'explore_by_instructor',
                            instructors: controller.explore.data!.instructors!),
                      SizedBox(
                          height:
                              controller.explore.data!.instructors!.isNotEmpty
                                  ? Dimensions.paddingSizeExtraLarge
                                  : 0),
                      if (controller.explore.data!.offeredCourses!.isNotEmpty)
                        OfferCourses(
                            offeredCourses:
                                controller.explore.data!.offeredCourses!),
                      const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
