import 'package:lms_user_app/data/model/quiz/data.dart';

class QuizModel {
  late bool success;
  late String message;
  late Data data;

  QuizModel({required this.success, required this.message, required this.data});

  QuizModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['data'] = this.data.toJson();
    return data;
  }
}
