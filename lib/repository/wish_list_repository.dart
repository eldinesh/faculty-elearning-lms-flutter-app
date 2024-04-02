import 'package:get/get.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class WishListRepository {
  final ApiClient apiClient;

  WishListRepository({required this.apiClient});

  Future<Response?> getWishList(int page) async {
    return await apiClient.getData("${AppConstants.myWishList}?page=$page&&type=course");
  }

  Future<Response?> addOrRemoveWishList(int id, String type) async {
    return apiClient.postData(
        AppConstants.addOrRemoveWishList, {'id': '$id', 'type': type});
  }
}
