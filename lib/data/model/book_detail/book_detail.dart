import 'data.dart';

class BookDetail {
  late bool success;
  late String message;
  late BookDetailData data;

  BookDetail({this.success = false, this.message = "", required this.data});

  factory BookDetail.fromJson(Map<String, Object?> json) => BookDetail(
        success: json['success'] as bool,
        message: json['message'] as String,
        data: BookDetailData.fromJson(json['data']! as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        'success': success,
        'message': message,
        'data': data.toJson(),
      };
}
