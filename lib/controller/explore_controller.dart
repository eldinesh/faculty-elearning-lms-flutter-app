import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/data/model/explore.dart';
import 'package:lms_user_app/repository/explore_repository.dart';

class ExploreController extends GetxController implements GetxService {
  final ExploreRepository exploreRepository;
  late Explore _explore;

  ExploreController({required this.exploreRepository});
  Explore get explore => _explore;
  bool isLoading = false;

  Future<void> getExploreData() async {
    isLoading = true;
    update();
    final response = await exploreRepository.getExploreData();
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        Explore exploreData = Explore.fromJson(response.body);
        _explore = exploreData;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body?['message'] ?? "");
    }
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    getExploreData();
    super.onInit();
  }
}
