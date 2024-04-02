import 'questions.dart';
import 'quiz.dart';

class Data {
  Quiz? quiz;
  List<Questions> questions = [];

  Data({this.quiz, required this.questions});

  Data.fromJson(Map<String, dynamic> json) {
    quiz = json['quiz'] != null ? Quiz.fromJson(json['quiz']) : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions.add(Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (quiz != null) {
      data['quiz'] = quiz!.toJson();
    }
    data['questions'] = questions.map((v) => v.toJson()).toList();
    return data;
  }
}
