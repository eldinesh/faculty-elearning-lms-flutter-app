import 'option.dart';

enum QuestionType { defaultQuestion, mcq, shortQuestion }

class Questions {
  late String question;
  late QuestionType questionType;
  List<Option>? option;
  List<int>? correctAnswerIndex;

  Questions(
      {required this.question,
      required this.questionType,
      this.option,
      this.correctAnswerIndex});

  Questions.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    //questionType = json['question_type'];
    switch (json['question_type']) {
      case 'short_question':
        questionType = QuestionType.shortQuestion;
        break;
      case 'mcq':
        questionType = QuestionType.mcq;
        break;
      case 'default':
        questionType = QuestionType.defaultQuestion;
        break;
      default:
        questionType = QuestionType.defaultQuestion;
        break;
    }
    if (json['option'] != null) {
      option = <Option>[];
      json['option'].forEach((v) {
        option!.add(Option.fromJson(v));
      });
    }
    if (json['correct_answer_index'] != null) {
      correctAnswerIndex = json['correct_answer_index'].cast<int>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['question_type'] = questionType;
    if (option != null) {
      data['option'] = option!.map((v) => v.toJson()).toList();
    }
    data['correct_answer_index'] = correctAnswerIndex;
    return data;
  }
}
