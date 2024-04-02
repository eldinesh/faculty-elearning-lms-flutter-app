import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';


class CategoryRepository {
  final ApiClient apiClient;
  CategoryRepository(this.apiClient);

  Future<Response?> getCategoryList() async {
    return apiClient.getData(AppConstants.courseCategories);
  }




}
