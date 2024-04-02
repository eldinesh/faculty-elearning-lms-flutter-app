import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';

class InstructorRepository {
  final ApiClient apiClient;

  InstructorRepository({required this.apiClient});

  Future<Response?> getInstructorProfile(int id) async {
    return await apiClient.getData("${AppConstants.instructorProfile}/$id");
  }

  Future<Response?> getCourseListOfInstructors(
      {required int id, required int page}) async {
    return await apiClient
        .getData("${AppConstants.instructorCourseList}/$id?page=$page");
  }

  Future<Response?> getStudentsList(
      {required int id, required int page}) async {
    return await apiClient
        .getData("${AppConstants.instructorStudentList}/$id?page=$page");
  }

  Future<Response?> followUnfollow(int id) async {
    return await apiClient.getData("${AppConstants.followUnfollow}/$id");
  }
}
