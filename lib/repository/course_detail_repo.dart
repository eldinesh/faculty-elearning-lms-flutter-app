import 'package:get/get.dart';
import 'package:lms_user_app/controller/splash_controller.dart';
import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class CourseDetailsRepository {
  final ApiClient apiClient;
  CourseDetailsRepository({required this.apiClient});

  Future<Response?> getCourseDetail({required int id}) async {
    final appConfig = Get.find<SplashController>().configModel.data!.appConfig.defaultCurrency;
    return apiClient.getData("${AppConstants.courseDetail}/$id&currency=$appConfig");
  }

  Future<Response?> getReviews(int id, int pageNumber) async {
    return apiClient
        .getData("${AppConstants.reviews}?id=$id&type=course&page=$pageNumber");
  }

  Future<Response?> postReview(
      {required int id, required String review, required double rating}) async {
    var body = {
      'id': id,
      'type': 'course',
      'rating': '$rating',
      'comment': review
    };
    return apiClient.postData(AppConstants.writeReviews, body);
  }
}
