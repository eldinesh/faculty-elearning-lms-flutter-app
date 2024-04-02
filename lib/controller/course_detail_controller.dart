import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/config.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/data/model/course_detail/course_detail.dart';
import 'package:lms_user_app/repository/course_detail_repo.dart';
import 'package:share_plus/share_plus.dart';
import '../components/custom_snackbar.dart';
import '../data/model/common/lesson.dart';
import '../data/model/user_review/review.dart';
import '../data/model/user_review/user_review.dart';
import '../feature/classRoom/widget/audio_player.dart';
import 'video_player_controller.dart';

class CourseDetailController extends GetxController implements GetxService {
  final CourseDetailsRepository courseDetailsRepository;
  CourseDetailController({required this.courseDetailsRepository});
  CourseDetail? _courseDetail;
  CourseDetail? get courseDetail => _courseDetail;
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  bool isBottomNavVisible = true;

  int pageNumber = 1;
  List<Review> reviews = [];
  bool isLoadingReviewsMore = false;
  bool hasMoreReviewData = true;

  //for video player
  String? selectedVideoUrl;
  bool playNewVideo = false;

  //rating
  final reviewTextController = TextEditingController();
  double _rating = 0.0;
  bool isReviewPosting = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        //scroll down
        if (isBottomNavVisible) {
          isBottomNavVisible = false;
          update();
        }
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        //scrolling up
        if (!isBottomNavVisible) {
          isBottomNavVisible = true;
          update();
        }
      }
    });
  }

  updateRating(double value) {
    _rating = value;
    update();
  }

  _hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  void share() {
    Share.share("${Config.baseUrl.replaceAll('api', 'course')}${_courseDetail?.data.slug ?? ''}");
  }

  void updateVideoUrl(bool fromCourseDetails ,String url, int id, String lessonId, String sectionId) async {
    selectedVideoUrl = url;
    playNewVideo = true;
    Get.put(MyVideoPlayerController()).playVideo(url, id, lessonId, sectionId);
    update();
  }

  void stopVideoPlayer() async {
    selectedVideoUrl = null;
    await Get.put(MyVideoPlayerController()).stopPlayer();
    update();
  }

  void openAudioPlayerDialog(Lesson lesson, String sectionID) {
    if (lesson.link.isEmpty) {
      customSnackBar('audio_file_error'.tr, isError: true);
      return;
    }
    stopVideoPlayer();
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
          onWillPop: () async => false, child: MyAudioPlayer(lesson: lesson,courseID: courseDetail!.data.id!,sectionID: sectionID,)),
    );
  }

  @override
  void dispose() {
    selectedVideoUrl = null;
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getCourseDetail({required int id}) async {
    printLog("-------course detail controller: $id");
    isLoading = true;
    _courseDetail = null;
    update();
    final response = await courseDetailsRepository.getCourseDetail(id: id);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        CourseDetail detail = CourseDetail.fromJson(response.body);
        _courseDetail = detail;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      printLog("-------course detail error: ${response?.statusCode}");
      customSnackBar("something_wrong".tr);
    }
    isLoading = false;
    update();
  }

  bool isSelect = false;
  curriculumButton() {
    isSelect = !isSelect;
    update();
  }

  Future<void> getReviews(int id) async {
    reviews = [];
    final response = await CourseDetailsRepository(apiClient: Get.find())
        .getReviews(id, pageNumber);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        UserReview review = UserReview.fromJson(response.body);
        reviews.addAll(review.data!.reviews!);
        if (review.data!.reviews!.isNotEmpty) {
          pageNumber++;
        } else {
          hasMoreReviewData = false;
        }
      }
    }
    update();
  }

  Future<void> postReview({required int id}) async {
    _hideKeyboard();
    isReviewPosting = true;
    update();
    String review = reviewTextController.text.isNotEmpty
        ? reviewTextController.text.toString()
        : "";

    final response = await courseDetailsRepository.postReview(
        id: id, review: review, rating: _rating);
    if (response != null) {
      reviewTextController.clear();
      Get.back();
      if(response.statusCode == 200){
        customSnackBar(response.body['message'],isError: false);
      }else{
        customSnackBar(response.body['message'], isError: true);
      }
    }
    pageNumber = 0;
    getReviews(id);
    isReviewPosting = !isReviewPosting;
    update();
  }

  Future<void> paginateReviews(int id) async {
    isLoadingReviewsMore == true;
    update();
    await getReviews(id);
    isLoadingReviewsMore == false;
    update();
  }
}
