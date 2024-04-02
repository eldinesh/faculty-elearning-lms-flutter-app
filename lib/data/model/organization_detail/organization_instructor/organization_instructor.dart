import 'data.dart';

class OrganizationInstructor {
	bool? success;
	String? message;
	Data? data;

	OrganizationInstructor({this.success, this.message, this.data});

	factory OrganizationInstructor.fromJson(Map<String, Object?> json) {
		return OrganizationInstructor(
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
