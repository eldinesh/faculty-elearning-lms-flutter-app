import 'package:get/get.dart';

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class QuizRepository {
  final ApiClient apiClient;
  QuizRepository({required this.apiClient});

  Future<Response?> getQuizData(int quizId) async {
    var body = {'quiz_id': quizId.toString()};
    return apiClient.postData(AppConstants.quizData, body);
  }
}
