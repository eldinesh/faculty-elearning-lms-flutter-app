
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/data/model/config_model.dart';
import 'package:lms_user_app/data/provider/checker_api.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/repository/splash_repo.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  ConfigModel _configModel = ConfigModel();
  ConfigModel get configModel => _configModel;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;
  bool get hasConnection => _hasConnection;

 
  void _saveConfigData(dynamic responseBody) {
    final box = GetStorage("config_data");
    box.write("config_data", responseBody);
  }

  ConfigModel? _retriveConfigDataFromLocal() {
    final box = GetStorage("config_data");
    return box.read("config_data") != null
        ? ConfigModel.fromJson(box.read("config_data"))
        : null;
  }

  Future<bool> getConfigData() async {
    _hasConnection = true;
    Response response = await splashRepo.getConfigData();
    if (response.statusCode == 200) {
      _saveConfigData(response.body);
      _configModel = ConfigModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
      if (response.statusText == ApiClient.noInternetMessage) {
        _hasConnection = false;
      }
    }
    update();
    return _retriveConfigDataFromLocal() != null;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }

  Future<bool> saveSplashSeenValue(bool value) async {
    return await splashRepo.setSplashSeen(value);
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  Future<bool> subscribeMail(String email) async {
    _isLoading = true;
    bool isSuccess = false;
    update();
    Response response = await splashRepo.subscribeEmail(email);
    if (response.statusCode == 200) {
      customSnackBar('subscribed_successfully'.tr, isError: false);
      isSuccess = true;
    } else {
      ApiChecker.checkApi(response);
    }
    _isLoading = false;
    update();
    return isSuccess;
  }

  bool isSplashSeen() => splashRepo.isSplashSeen();
}
