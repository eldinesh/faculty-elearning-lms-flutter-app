import 'package:get/get.dart';
import 'package:lms_user_app/data/model/quiz/quiz_model.dart';

import '../repository/quiz_repository.dart';

class QuizController extends GetxController implements GetxService {
  final QuizRepository quizRepo;
  QuizController({required this.quizRepo});

  bool _isDataLoading = false;
  bool get isDataLoading => _isDataLoading;
  QuizModel? _quizModel;
  QuizModel? get quizModel => _quizModel;

  Future<void> getQuizData(int quizId) async {
    _isDataLoading = true;
    update();
    final response = await quizRepo.getQuizData(quizId);
    if (response != null && response.statusCode == 200) {
     // printLog("-------id:$quizId \n and response: ${response.body}");
      _quizModel = QuizModel.fromJson(response.body);
    }
    _isDataLoading = false;
    update();
  }
}
