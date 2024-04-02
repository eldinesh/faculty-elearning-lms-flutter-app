import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/data/provider/checker_api.dart';
import 'package:lms_user_app/repository/search_repo.dart';
import 'auth_controller.dart';

class SearchController extends GetxController implements GetxService {
  final SearchRepo searchRepo;
  SearchController({required this.searchRepo});

  List<Course>? _searchCourseList;
  String? _searchText = '';
  List<String>? _historyList = [];
  final List<String> _sortList = ['ascending'.tr, 'descending'.tr];
  bool _isLoading = false;
  bool _isSearchComplete = false;
  bool _isActiveSuffixIcon = false;
  List<Course>? get searchResultCourseList => _searchCourseList;
  String? get searchText => _searchText;
  List<String>? get historyList => _historyList;
  List<String>? get sortList => _sortList;
  bool? get isLoading => _isLoading;
  bool get isSearchComplete => _isSearchComplete;
  bool get isActiveSuffixIcon => _isActiveSuffixIcon;

  bool? _isLoggedIn;
  var searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _isLoggedIn = Get.find<AuthController>().isLoggedIn();
    if (_isLoggedIn!) {
      // getSuggestedFoods();
    }
    getHistoryList();
    searchController.text = '';
  }

  void setSearchText(String text) {
    _searchText = text;
    update();
  }

  Future<void> navigateToSearchResultScreen() async {
    if (searchController.value.text.trim().isNotEmpty) {
      if (Get.currentRoute.contains('/search?query=')) {
        Get.offNamed(RouteHelper.getSearchResultRoute(
            queryText: searchController.value.text.trim()));
      } else {
        Get.toNamed(RouteHelper.getSearchResultRoute(
            queryText: searchController.value.text.trim()));
      }
    }
  }

  Future<void> clearSearchController() async {
    if (searchController.value.text.trim().isNotEmpty) {
      searchController.clear();
      _isActiveSuffixIcon = false;
      update();
    }
  }

  Future<void> populatedSearchController(String historyText) async {
    searchController.clear();
    searchController = TextEditingController(text: historyText);
    _isActiveSuffixIcon = true;
    update();
  }

  Future<void> searchData(String query, {bool shouldUpdate = true}) async {
    _isLoading = true;
    update();

    if (query.isNotEmpty) {
      _searchText = query;
      _searchCourseList = [];
      if (!_historyList!.contains(query)) {
        _historyList!.insert(0, query);
      }
      searchRepo.saveSearchHistory(_historyList!);
      if (shouldUpdate) {
        update();
      }
      Response response = await searchRepo.getSearchData(query);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchCourseList = [];
        } else {
          _searchCourseList = [];
          _searchCourseList!
              .addAll(CourseModel.fromJson(response.body).content!.courses!);
        }
      } else {
        ApiChecker.checkApi(response);
      }
      _isSearchComplete = true;
      _isLoading = false;
      update();
    }
  }

  void showSuffixIcon(context, String text) {
    if (text.isNotEmpty) {
      _isActiveSuffixIcon = true;
    } else if (text.isEmpty) {
      _isActiveSuffixIcon = false;
    }
    update();
  }

  void getHistoryList() {
    _searchText = '';
    _historyList = [];
    if (searchRepo.getSearchAddress().isNotEmpty) {
      _historyList!.addAll(searchRepo.getSearchAddress());
    }
  }

  void removeHistory(String index) {
    _historyList!.remove(index);
    searchRepo.saveSearchHistory(_historyList!);
    update();
  }

  List<String>? filterHistory(String pattern, List<String>? value) {
    List<String>? list = [];

    value?.forEach((history) {
      if (history.contains(pattern.toLowerCase())) {
        list.add(history);
      }
    });
    return list;
  }

  void clearSearchAddress() async {
    searchRepo.clearSearchHistory();
    _historyList = [];
    update();
  }

  void removeService() async {
    _searchCourseList = null;
    _isSearchComplete = false;
    // searchController.clear();
  }
}
