
import 'package:get/get.dart';

import '../components/custom_snackbar.dart';
import '../data/model/common/course.dart';
import '../data/model/common/latest_course_list/latest_course_list.dart';
import '../data/model/home_data_model/home_data_model.dart';
import '../repository/home_repository.dart';

class HomeController extends GetxController implements GetxService {
  HomeController({required this.homeRepository});

  final HomeRepository homeRepository;
  HomeDataModel? _homeModel;
  HomeDataModel? get homeModel => _homeModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _currentIndex = 0;
  int? get currentIndex => _currentIndex;
  final List<Course> _latestCourseList = [];
  List<Course>? get latestCourseList => _latestCourseList;
  int _pageNumber = 1;
  int get pageNumber => _pageNumber;
  bool _isLoadingMoreData = false;
  bool get isLoadingMoreData => _isLoadingMoreData;

  @override
  void onInit() {
    getHomeData();
    getLatestCourseList();
    super.onInit();
  }

  Future<void> getHomeData() async {
    _isLoading = true;
    _homeModel == null;
    update();
    final response = await homeRepository.getHomeData();
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        HomeDataModel data = HomeDataModel.fromJson(response.body);
        _homeModel = data;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body?['message']);
    }
    _isLoading = false;
    update();
  }

  Future<void> getLatestCourseList() async {
    final response = await homeRepository.getLatestCourse(_pageNumber);
    if (response != null && response.statusCode == 200) {
      LatestCourseList list = LatestCourseList.fromJson(response.body);
      _latestCourseList.addAll(list.data!.courses!);
      if (list.data!.courses!.isNotEmpty) {
        _pageNumber++;
      }
      update();
    }
  }

  Future<void> paginate() async {
    _isLoadingMoreData = true;
    update();
    await getLatestCourseList();
    _isLoadingMoreData = false;
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }
}
