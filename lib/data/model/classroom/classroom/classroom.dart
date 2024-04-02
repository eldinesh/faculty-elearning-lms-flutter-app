import 'data.dart';

class Classroom {
	bool? success;
	String? message;
	Data? data;

	Classroom({this.success, this.message, this.data});

	factory Classroom.fromJson(Map<String, Object?> json) => Classroom(
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
