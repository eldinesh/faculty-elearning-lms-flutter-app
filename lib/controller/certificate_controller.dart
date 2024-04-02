import 'package:get/get.dart';
import 'package:lms_user_app/config.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/data/provider/checker_api.dart';
import 'package:lms_user_app/repository/certificate_repository.dart';
import 'package:lms_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CertificateController extends GetxController implements GetxService {

  bool isCartDataLoading = false;
  List<Course>? _courseList;
  List<Course>? get courseList => _courseList;
  String? _certificateDownloadUrl;
  String? get certificateDownloadUrl => _certificateDownloadUrl;


  Future<void> getCourseBasedOnCertificate(int offset,bool reload) async {
    if(reload){
      _courseList = null;
    }
    final response = await CertificateRepository(Get.find()).getCertificateBasedCourseList();
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

   getCertificateDownloadLink(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);
    _certificateDownloadUrl = "${Config.baseUrl}${AppConstants.certificateDownload}/$id?token=$token";
    update();
  }

}
