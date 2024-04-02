import 'package:get/get_connect/http/src/response/response.dart';
import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';
import 'package:get/get.dart';


class ResourceRepository {
  final ApiClient apiClient;
  ResourceRepository(this.apiClient);

  Future<Response?> getResourceList(String courseID) async {
    return apiClient.getData("${AppConstants.myResources}/$courseID");
  }

}
