import 'package:get/get.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SplashRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getConfigData() async {
    Map<String, String> mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Response response =
        await apiClient.getData(AppConstants.configUrl, headers: mainHeaders);
    return response;
  }

  Future<bool> initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.theme)) {
      sharedPreferences.setBool(AppConstants.theme, false);
    }
    if (!sharedPreferences.containsKey(AppConstants.countryCode)) {
      sharedPreferences.setString(
          AppConstants.countryCode, AppConstants.languages[0].countryCode!);
    }
    if (!sharedPreferences.containsKey(AppConstants.languageCode)) {
      sharedPreferences.setString(
          AppConstants.languageCode, AppConstants.languages[0].languageCode!);
    }

    if (!sharedPreferences.containsKey(AppConstants.notification)) {
      sharedPreferences.setBool(AppConstants.notification, true);
    }
    return Future.value(true);
  }

  Future<bool> setSplashSeen(bool isSplashSeen) async {
    return await sharedPreferences.setBool(
        AppConstants.isOnBoardScreen, isSplashSeen);
  }

  bool isSplashSeen() {
    return sharedPreferences.getBool(AppConstants.isOnBoardScreen) != null
        ? sharedPreferences.getBool(AppConstants.isOnBoardScreen)!
        : false;
  }

  Future<Response> subscribeEmail(String email) async {
    return await apiClient
        .postData(AppConstants.subscriptionUrl, {'email': email});
  }
}
