import 'package:get/get.dart';
import 'package:lms_user_app/data/model/common/my_course.dart';
import 'package:lms_user_app/data/model/my_course_list/my_course_list.dart';
import 'package:lms_user_app/repository/my_course_repository.dart';

class MyCourseController extends GetxController implements GetxService {
  final MyCourseRepository repository;
  MyCourseController({required this.repository});

  final List<MyCourse> _myCourseList = [];
  List<MyCourse> get myCourseList => _myCourseList;
  bool _isMyCourseDataLoading = false;
  bool get isMyCourseLoading => _isMyCourseDataLoading;
  bool _isMyCourseLoadingMore = false;
  bool get isMyCourseLoadingMore => _isMyCourseLoadingMore;
  int _currentPage = 1;

  Future<void> getMyCourseList() async {
    _isMyCourseDataLoading = true;
    update();
    final response = await repository.getMyCourseList(_currentPage);
    if (response != null && response.statusCode == 200) {
      if (response.body['success']) {
        MyCourseList list = MyCourseList.fromJson(response.body);
        _myCourseList.clear();
        _myCourseList.addAll(list.data!.courses!);
      }
    }
    _isMyCourseDataLoading = false;
    update();
  }

  Future<void> paginatePurchaseCourse() async {
    _isMyCourseLoadingMore = true;
    update();
    final response = await repository.getMyCourseList(_currentPage);
    if (response != null && response.statusCode == 200) {
      if (response.body['success']) {
        MyCourseList list = MyCourseList.fromJson(response.body);
        _myCourseList.addAll(list.data!.courses!);
        if (list.data!.courses!.isNotEmpty) {
          _currentPage++;
        }
      }
    }
    _isMyCourseLoadingMore = false;
    update();
  }
}
