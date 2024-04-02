
import 'package:lms_user_app/data/model/common/quiz.dart';

import 'lesson.dart';

class Section {
  int? id;
  String? title;
  List<Lesson>? lessons;
  List<Quiz>? quizes;

  Section({this.id, this.title, this.lessons, this.quizes});

  factory Section.fromJson(Map<String, Object?> json) => Section(
        id: json['id'] as int?,
        title: json['title'] as String?,
        lessons: (json['lessons'] as List<dynamic>?)
            ?.map((e) => Lesson.fromJson(e as Map<String, Object?>))
            .toList(),
        quizes: (json['quizzes'] as List<dynamic>?)
            ?.map((e) => Quiz.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'lessons': lessons?.map((e) => e.toJson()).toList(),
        'quizzes': quizes?.map((e) => e.toJson()).toList(),
      };
}
