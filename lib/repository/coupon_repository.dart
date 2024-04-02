import 'package:get/get_connect/http/src/response/response.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class CouponRepository {
  final ApiClient apiClient;
  CouponRepository(this.apiClient);

  Future<Response?> getCouponList() async {
    return apiClient.getData(AppConstants.couponList);
  }
}
