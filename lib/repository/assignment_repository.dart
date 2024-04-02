import 'package:get/get_connect/http/src/response/response.dart';
import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';
import 'dart:io';
import 'package:get/get.dart';



class AssignmentRepository {
  final ApiClient apiClient;
  AssignmentRepository(this.apiClient);

  Future<Response?> getAssignmentList() async {
    return apiClient.getData(AppConstants.myAssignment);
  }

  Future<Response?> submitAssignment({required String? assignmentId,required File? file}) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      'assignment_id': assignmentId!,
    });

    return await apiClient.postMultipartData(AppConstants.submitAssignment, body, [],file);
  }
}
