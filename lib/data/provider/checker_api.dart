import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode != 200) {
      Get.find<AuthController>().clearSharedData();
      Get.offAllNamed(RouteHelper.getSignInRoute('splash'));
    }else{
      customSnackBar("${response.statusCode!}".tr);
    }
  }
}