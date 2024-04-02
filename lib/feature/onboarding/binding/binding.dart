import 'package:get/get.dart';
import 'package:lms_user_app/controller/on_board_pager_controller.dart';
import 'package:lms_user_app/repository/on_board_repository.dart';

class OnBoardBinding extends Bindings{
  @override
  void dependencies() async {
    Get.lazyPut(() => OnBoardController(repository: OnBoardRepository(apiClient: Get.find())));
  }
}