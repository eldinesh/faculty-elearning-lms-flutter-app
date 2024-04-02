import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';


class CertificateRepository {
  final ApiClient apiClient;
  CertificateRepository(this.apiClient);

  Future<Response?> getCertificateBasedCourseList() async {
    return apiClient.getData(AppConstants.certificates);
  }

  getCertificateDownloadLink(String certificateID) async {

    return apiClient.getData("${AppConstants.certificateDownload}/$certificateID");

  }
  
}
