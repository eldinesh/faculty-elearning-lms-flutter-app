import 'package:get/get.dart';
import 'package:lms_user_app/data/model/config_model.dart';
import 'package:lms_user_app/data/provider/checker_api.dart';
import 'package:lms_user_app/repository/splash_repo.dart';

class HtmlViewController extends GetxController implements GetxService {
  SplashRepo splashRepo;
  HtmlViewController({required this.splashRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ConfigModel? _configModel;
  Pages? get pagesContent => _configModel?.data?.pages;

  Future<void> getPagesContent() async {
    _isLoading = true;
    update();
    Response response = await splashRepo.getConfigData();
    if (response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
  }
}
