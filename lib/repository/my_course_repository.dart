import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';

class MyCourseRepository {
  final ApiClient apiClient;

  MyCourseRepository({required this.apiClient});

  Future<Response?> getMyCourseList(int page) async {
    return await apiClient.getData("${AppConstants.myCourseList}?page=$page");
  }

  
}
