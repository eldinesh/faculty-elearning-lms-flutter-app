import 'package:lms_user_app/data/model/book_store_model/all_books/all_books_data.dart';

class AllBooks {
  bool? success;
  String? message;
  AllBooksData? data;

  AllBooks({this.success, this.message, this.data});

  factory AllBooks.fromJson(Map<String, Object?> json) {
    return AllBooks(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AllBooksData.fromJson(json['data']! as Map<String, Object?>),
    );
  }

  Map<String, Object?> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}
