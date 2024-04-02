import 'package:get/get_connect/http/src/response/response.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class CourseProgressRepository {
  final ApiClient apiClient;
  CourseProgressRepository(this.apiClient);


  Future<Response?> saveProgress({
      required int id,
      required String lessonID,
      required String sectionID,
      required String totalSpentTime,
      required String totalDuration}) async {
            var body = {
                    'course_id': id,
                    'lesson_id': lessonID,
                    'section_id': sectionID,
                    // 'total_spent_time': totalSpentTime,
                    'total_spent_time': totalDuration,
                    'total_duration': totalDuration,
                };

    return apiClient.postData(AppConstants.saveProgress, body);
  }

}
