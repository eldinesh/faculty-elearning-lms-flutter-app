import 'package:get/get.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class ClassroomRepo {
  final ApiClient apiClient;

  ClassroomRepo(this.apiClient);

  Future<Response?> getClassroomData({required int courseID})async{
    return apiClient.getData("${AppConstants.courseSection}/$courseID");
  }
}