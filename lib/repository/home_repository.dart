import 'package:get/get.dart';
import 'package:lms_user_app/controller/splash_controller.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class HomeRepository {
  final ApiClient apiClient;
  HomeRepository({required this.apiClient});

  Future<Response?> getHomeData() async {
    return apiClient.getData(AppConstants.homeScreen);
  }

  Future<Response?> getLatestCourse(int page) async {
    final appConfig = Get.find<SplashController>().configModel.data!.appConfig.defaultCurrency;
    return apiClient.getData("${AppConstants.latestCourse}?page=$page&currency=$appConfig");
  }
}
