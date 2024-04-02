import 'data.dart';

class LatestCourseList {
	bool? success;
	String? message;
	Data? data;

	LatestCourseList({this.success, this.message, this.data});

	factory LatestCourseList.fromJson(Map<String, Object?> json) {
		return LatestCourseList(
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
