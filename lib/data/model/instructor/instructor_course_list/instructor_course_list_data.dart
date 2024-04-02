import '../../common/course.dart';

class InstructorCourseListData {
  List<Course>? courses;

  InstructorCourseListData({this.courses});

  factory InstructorCourseListData.fromJson(Map<String, Object?> json) =>
      InstructorCourseListData(
        courses: (json['courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'courses': courses?.map((e) => e.toJson()).toList(),
      };
}
