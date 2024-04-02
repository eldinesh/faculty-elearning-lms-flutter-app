import 'package:get/get.dart';
import 'package:lms_user_app/data/model/order/order_history_list/order_history.dart';
import 'package:lms_user_app/data/model/order/order_history_list/order_history_list.dart';
import 'package:lms_user_app/repository/order_repository.dart';

class OrderController extends GetxController implements GetxService {
  bool isLoadingOrderHistory = false;
  int orderHistoryPage = 1;
  List<OrderHistory> orderHistoryList = [];

  Future<void> getOrderHistory(String type) async {
    isLoadingOrderHistory = true;
    update();
    final response = await OrderRepository(Get.find())
        .getOrderHistory(orderHistoryPage, type);
    if (response != null && response.statusCode == 200) {
      OrderHistoryList model = OrderHistoryList.fromJson(response.body);
      if (model.data != null && model.data!.orderHistories!.isNotEmpty) {
        orderHistoryList.clear();
        orderHistoryList.addAll(model.data!.orderHistories!);
      }
    }
    isLoadingOrderHistory = false;
    update();
  }
}
