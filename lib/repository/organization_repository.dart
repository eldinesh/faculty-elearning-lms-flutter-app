import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';

class OrganizationRepository {
  final ApiClient apiClient;
  OrganizationRepository({required this.apiClient});

  Future<Response?> getOrganizationProfile(int id) async {
    return await apiClient.getData("${AppConstants.organizationProfile}/$id");
  }

  Future<Response?> getOrganizationCourseList(int id, int page) async {
    return await apiClient
        .getData("${AppConstants.organizationCourseList}/$id?page=$page");
  }

  Future<Response?> getOrganizationInstructorList(int id, int page) async {
    return await apiClient
        .getData("${AppConstants.organizationInstructorList}/$id?page=$page");
  }
}
