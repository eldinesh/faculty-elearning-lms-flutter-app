import 'data.dart';

class MyCourseList {
	bool? success;
	String? message;
	Data? data;

	MyCourseList({this.success, this.message, this.data});

	factory MyCourseList.fromJson(Map<String, Object?> json) => MyCourseList(
				success: json['success'] as bool?,
				message: json['message'] as String?,
				data: json['data'] == null
						? null
						: Data.fromJson(json['data']! as Map<String, Object?>),
			);

	Map<String, Object?> toJson() => {
				'success': success,
				'message': message,
				'data': data?.toJson(),
			};
}
