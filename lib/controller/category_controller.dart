import 'package:get/get.dart';
import 'package:lms_user_app/data/model/common/category.dart';
import 'package:lms_user_app/repository/category_repository.dart';

class CategoryController extends GetxController implements GetxService {
  bool isCartDataLoading = false;

  List<Category>? _categoryList;

  List<Category>? get categoryList => _categoryList;



  Future<void> getCategoryList() async {
    isCartDataLoading = true;
    update();
    final response = await CategoryRepository(Get.find()).getCategoryList();
    if (response != null && response.statusCode == 200) {
      _categoryList = [];
      response.body['data']['categories'].forEach((category) {
        _categoryList!.add(Category.fromJson(category));
      });
    }
    isCartDataLoading = false;
    update();
  }

}
