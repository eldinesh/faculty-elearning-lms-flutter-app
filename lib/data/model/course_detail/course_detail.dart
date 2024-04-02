import 'data.dart';

class CourseDetail {
  late bool success;
  late String message;
  late CourseDetailData data;

  CourseDetail(
      {required this.success, required this.message, required this.data});

  factory CourseDetail.fromJson(Map<String, Object?> json) => CourseDetail(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: CourseDetailData.fromJson(json['data']! as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}
