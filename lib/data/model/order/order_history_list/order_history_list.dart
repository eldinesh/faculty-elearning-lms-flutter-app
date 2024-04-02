import 'data.dart';

class OrderHistoryList {
	bool? success;
	String? message;
	Data? data;

	OrderHistoryList({this.success, this.message, this.data});

	factory OrderHistoryList.fromJson(Map<String, Object?> json) {
		return OrderHistoryList(
			success: json['success'] as bool?,
			message: json['message'] as String?,
			data: json['data'] == null
						? null
						: Data.fromJson(json['data']! as Map<String, Object?>),
		);
	}



	Map<String, Object?> toJson() => {
				'success': success,
				'message': message,
				'data': data?.toJson(),
			};
}
