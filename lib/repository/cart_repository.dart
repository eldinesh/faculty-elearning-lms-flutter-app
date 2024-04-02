import 'package:get/get_connect/http/src/response/response.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class CartRepository {
  final ApiClient apiClient;
  CartRepository(this.apiClient);

  Future<Response?> getCartList() async {
    return apiClient.getData(AppConstants.cartList);
  }

  Future<Response?> addToCart(int id, String type) async {
    var body = {'id': id, 'type': type};
    return apiClient.postData(AppConstants.addToCart, body);
  }

  Future<Response?> removeFromCart(int id, String type) async {
    return apiClient.deleteData("${AppConstants.removeFromCart}/$id");
  }

  Future<Response?> applyCoupon(
      {required String code, required String type, required String id}) async {
    var body = {'type': type, 'id': id, 'code': code};
    return apiClient.postData(AppConstants.applyCoupon, body);
  }
}
