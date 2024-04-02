import 'package:lms_user_app/data/model/common/book.dart';

class AllBooksData {
  List<BookModel>? books;

  AllBooksData({this.books});

  factory AllBooksData.fromJson(Map<String, Object?> json) => AllBooksData(
        books: (json['books'] as List<dynamic>?)
            ?.map((e) => BookModel.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'books': books?.map((e) => e.toJson()).toList(),
      };
}
