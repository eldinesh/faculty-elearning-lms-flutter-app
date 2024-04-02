import 'package:get/get_connect/http/src/response/response.dart';
import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class MeetingRepository {
  final ApiClient apiClient;
  MeetingRepository(this.apiClient);

  Future<Response?> getMeetingList() async {
    return apiClient.getData(AppConstants.meetingList);
  }
}
