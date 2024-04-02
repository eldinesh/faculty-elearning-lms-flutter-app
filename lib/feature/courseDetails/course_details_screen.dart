import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/controller/course_detail_controller.dart';
import 'package:lms_user_app/feature/classRoom/widget/video_player.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/button_section.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/course_curriculum.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/course_features.dart';
import 'package:lms_user_app/feature/common/course_instructor.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/course_overview.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/course_resource.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/course_review.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/frequently_ask_question.dart';
import 'package:lms_user_app/feature/common/organization.dart';
import 'package:lms_user_app/feature/courseDetails/widgets/related_course.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../controller/wishlist_controller.dart';
import '../../data/model/course_detail/course_detail.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  bool isSelect = false;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

  }

  void _onPlayerStateChange() {
    if (_controller.value.playerState == PlayerState.playing) {
      setState(() {
      });
    }
  }


  @override
  void dispose() {
    Get.find<CourseDetailController>().stopVideoPlayer();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        // title: 'course_details'.tr,
        titleColor: Theme.of(context).textTheme.bodyLarge?.color,
        bgColor: Theme.of(context).canvasColor,
        actions: [
          if (Get.find<AuthController>().isLoggedIn())
          IconButton(
            onPressed: () => Get.find<WishListController>()
                .addToWishList(Get.arguments, 'course'),
            icon: SvgPicture.asset(
                Images.heart,
                color: Theme.of(context).textTheme.bodyLarge?.color),
            splashRadius: 23,
          ),
          IconButton(
            onPressed: () => Get.find<CourseDetailController>().share(),
            icon: SvgPicture.asset(Images.share, color: Theme.of(context).textTheme.bodyLarge?.color),
            splashRadius: 23,
          ),
        ],
      ),
      body: GetBuilder<CourseDetailController>(
        initState: (state){
          Get.find<CourseDetailController>().getCourseDetail(id: Get.arguments);
        },
        builder: (controller) {
          return controller.isLoading || controller.courseDetail == null
              ? const LoadingIndicator()
              : mainUI(context, controller.courseDetail!, controller);
        },
      ),
      bottomNavigationBar: GetBuilder<CourseDetailController>(builder: (controller) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          height: controller.isBottomNavVisible
              ? kBottomNavigationBarHeight * 2.3
              : 0,
          child: controller.isLoading || controller.courseDetail == null
              ? const SizedBox()
              : OverflowBox(
                  minHeight: 0,
                  maxHeight: double.infinity,
                  alignment: Alignment.topCenter,
                  child: ButtonSection(data: controller.courseDetail!.data)),
        );
      }),
    );
  }

  Widget mainUI(BuildContext context, CourseDetail courseDetail,
      CourseDetailController controller) {

    if(courseDetail.data.videoSource == "youtube"){
      _controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(courseDetail.data.videoLink!)!,
          flags: const YoutubePlayerFlags(autoPlay: true, mute: false));
    }

    return SingleChildScrollView(
      controller: controller.scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            controller.selectedVideoUrl != null && controller.playNewVideo == true
                ? courseDetail.data.videoSource == "youtube"? Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                      margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                          child: YoutubePlayer(controller: _controller),
                ):
            Container(
                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.orange.withOpacity(0.2),
                    child: CourseVideoPlayer(
                      videoUrl: courseDetail.data.videoLink!,
                    ),
                  )
                : Container(
                    height: 160,
                    margin: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSmall)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            controller.updateVideoUrl(true,courseDetail.data.videoLink!,0,'0','0');
                          },
                          icon: SvgPicture.asset(Images.play)),
                    ),
                  ),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            CourseOverView(data: courseDetail.data),
            const SizedBox(height: 30),
            if (courseDetail.data.features != null)
              CourseFeatures(feature: courseDetail.data.features!),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            CourseInstructor(
                title: 'course_instructor',
                instructors: courseDetail.data.instructors!),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            //course curriculum
            if (courseDetail.data.sections!.isNotEmpty)
              CourseCurriculum(
                  sections: courseDetail.data.sections!,
                  controller: controller),
            SizedBox(
                height: courseDetail.data.sections!.isNotEmpty
                    ? Dimensions.paddingSizeDefault
                    : 0),
            if (courseDetail.data.resources?.isAudioAvailable == true ||
                courseDetail.data.resources?.isDocAvailable == true ||
                courseDetail.data.resources?.isVideoAvailable == true)
              CourseResource(resource: courseDetail.data.resources!),
            SizedBox(
                height: courseDetail.data.resources?.isAudioAvailable == true ||
                        courseDetail.data.resources?.isDocAvailable == true ||
                        courseDetail.data.resources?.isVideoAvailable == true
                    ? Dimensions.paddingSizeDefault
                    : 0),
            CourseReview(
                courseId: courseDetail.data.id!,
                totalReview: courseDetail.data.totalReviews ?? 0,
                avgRatings: courseDetail.data.avgRatings ?? "0.0",
                isReviewed: courseDetail.data.isReviewed ?? false,
                isCanReview: courseDetail.data.canReview ?? false),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            if (courseDetail.data.relatedCourses!.isNotEmpty)
              RelatedCourse(courses: courseDetail.data.relatedCourses!),
            SizedBox(
                height: courseDetail.data.relatedCourses!.isNotEmpty
                    ? Dimensions.paddingSizeExtraLarge
                    : 0),
            if (courseDetail.data.faqs!.isNotEmpty)
              FrequentlyAskQuestion(faqList: courseDetail.data.faqs!),
            SizedBox(
                height: courseDetail.data.faqs!.isNotEmpty
                    ? Dimensions.paddingSizeDefault
                    : 0),
            //organization section
            if (courseDetail.data.organization != null)
              OrganizationWidget(organization: courseDetail.data.organization!),
            const SizedBox(height: Dimensions.paddingSizeDefault),
          ]),
    );
  }
}
