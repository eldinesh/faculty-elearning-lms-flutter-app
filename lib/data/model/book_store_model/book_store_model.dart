import 'book_store_data.dart';

class BookStoreModel {
	bool? success;
	String? message;
	List<BookStoreData>? data;

	BookStoreModel({this.success, this.message, this.data});

	factory BookStoreModel.fromJson(Map<String, Object?> json) {
		return BookStoreModel(
			success: json['success'] as bool?,
			message: json['message'] as String?,
			data: (json['data'] as List<dynamic>?)
						?.map((e) => BookStoreData.fromJson(e as Map<String, Object?>))
						.toList(),
		);
	}



	Map<String, Object?> toJson() => {
				'success': success,
				'message': message,
				'data': data?.map((e) => e.toJson()).toList(),
			};
}
