import 'package:get/get.dart';
import 'package:lms_user_app/controller/splash_controller.dart';
import 'package:lms_user_app/utils/app_constants.dart';
import '../data/provider/client_api.dart';

class ExploreRepository {
  final ApiClient apiClient;
  ExploreRepository({required this.apiClient});

  Future<Response?> getExploreData() async {
    final appConfig = Get.find<SplashController>().configModel.data!.appConfig.defaultCurrency;
    return apiClient.getData("${AppConstants.explore}?currency=$appConfig");
  }
}
