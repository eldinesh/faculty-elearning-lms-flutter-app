import 'package:lms_user_app/data/model/common/my_course.dart';

class Data {
  List<MyCourse>? courses;

  Data({this.courses});

  factory Data.fromJson(Map<String, Object?> json) => Data(
        courses: (json['courses'] as List<dynamic>?)
            ?.map((e) => MyCourse.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'courses': courses?.map((e) => e.toJson()).toList(),
      };
}
