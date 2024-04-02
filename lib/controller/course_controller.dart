import 'package:get/get.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/data/provider/checker_api.dart';
import 'package:lms_user_app/repository/course_repository.dart';

class CourseController extends GetxController implements GetxService {

  bool isCartDataLoading = false;
  List<Course>? _courseList;
  List<Course>? get courseList => _courseList;




  Future<void> getCategoryBasedCourseList(int offset,String categoryID,bool reload) async {
    if(reload){
      _courseList = null;
    }
    final response = await CourseRepository(Get.find()).getCategoryBasedCourseList(categoryID);
    if (response != null && response.statusCode == 200) {
      if(_courseList != null && offset != 1){
        response.body['data']['courses'].forEach((category) {
          _courseList!.add(Course.fromJson(category));
        });
      }else{
        _courseList = [];
        response.body['data']['courses'].forEach((category) {
          _courseList!.add(Course.fromJson(category));
        });
      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }
}
