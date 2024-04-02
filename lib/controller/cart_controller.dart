import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/controller/course_detail_controller.dart';
import 'package:lms_user_app/data/model/cart_list/cart_list.dart';
import 'package:lms_user_app/repository/course_detail_repo.dart';

import '../data/model/cart_list/calculations.dart';
import '../data/model/cart_list/cart.dart';
import '../repository/cart_repository.dart';
import 'auth_controller.dart';

class CartController extends GetxController implements GetxService {
  bool isCartDataLoading = false;

  List<Cart> cartList = [];
  Calculations? calculations;

  //apply coupon
  int selectedCartItemIndex = -1;
  bool isApplyCouponLoading = false;
  final couponInputController = TextEditingController();
  int deletingCartIndex = -1;
  bool isDeletingFromCart = false;

  bool isCartItemDeleting(int index) => index == deletingCartIndex;

  void deletingIndex(int index) {
    deletingCartIndex = index;
    update();
  }

  bool isApplyCouponPressed(int index) {
    return index == selectedCartItemIndex;
  }

  void selectedIndex(int index) {
    selectedCartItemIndex = index;
    update(["cart"]);
  }

  @override
  void onInit() {
    getCartList();
    super.onInit();
  }

  Future<void> clearCartList() async {
    cartList.clear();
    await getCartList();
    update();
  }

  bool isCartListContainCourseId(int id) {
    return cartList.any((cart) => cart.courseId == id);
  }

  Future<void> getCartList() async {
    isCartDataLoading = true;
    update();
    final response = await CartRepository(Get.find()).getCartList();
    if (response != null && response.statusCode == 200) {
      CartList cart = CartList.fromJson(response.body);
      calculations = cart.data!.calculations;
      cartList.clear();
      cartList.addAll(cart.data!.carts!);
    }
    isCartDataLoading = false;
    update();
  }

  Future<void> addToCart(int id, String type) async {
    // check user is logged in or not.
    //if not, show a message
    if (!Get.find<AuthController>().isLoggedIn()) {
      customSnackBar('login_to_add_this_to_cart'.tr, isError: true);
      return;
    }
    isCartDataLoading = true;
    update();
    final response = await CartRepository(Get.find()).addToCart(id, type);
    if (response != null) {
      customSnackBar(response.body['message'],
          isError: response.statusCode != 200);
    }
    await getCartList();
    Get.put(CourseDetailController(
            courseDetailsRepository:
                CourseDetailsRepository(apiClient: Get.find())))
        .courseDetail
        ?.data
        .isAddedToCart = true;
    isCartDataLoading = false;
    update();
  }

  Future<void> removeFromCart({required int id, required String type}) async {
    isDeletingFromCart = true;
    update();
    final response = await CartRepository(Get.find()).removeFromCart(id, type);
    if (response != null) {
      customSnackBar(response.body['message'].toString(),
          isError: response.statusCode != 200);
    }
    //now update cart list data again
    final cartResponse = await CartRepository(Get.find()).getCartList();
    if (cartResponse != null && cartResponse.statusCode == 200) {
      CartList cart = CartList.fromJson(cartResponse.body);
      calculations = cart.data!.calculations;
      cartList.clear();
      cartList.addAll(cart.data!.carts!);
    }

    deletingIndex(-1);
    isDeletingFromCart = false;
    update();
  }

  Future<void> applyCoupon(
      {required String code, required String type, required String id}) async {
    isApplyCouponLoading = true;
    update();
    final response = await CartRepository(Get.find())
        .applyCoupon(code: code, type: type, id: id);
    if (response != null && response.statusCode == 200) {
      customSnackBar(response.body['message'] ?? "", isError: false);
    } else {
      customSnackBar(
          response?.body['message'] ??
              response?.body['errors']['code'].toString(),
          isError: false);
    }
    await getCartList();
    isApplyCouponLoading = false;
    update();
  }
}
