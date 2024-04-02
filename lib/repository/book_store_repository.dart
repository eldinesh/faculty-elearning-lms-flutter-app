import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';

import '../utils/app_constants.dart';

class BookStoreRepository {
  final ApiClient apiClient;
  BookStoreRepository({required this.apiClient});

  Future<Response?> getBookStoreData() async {
    return apiClient.getData(AppConstants.bookStore);
  }

  Future<Response?> getLatestBooks(int page) async {
    return apiClient.getData("${AppConstants.latestBooks}?page=$page");
  }
}
