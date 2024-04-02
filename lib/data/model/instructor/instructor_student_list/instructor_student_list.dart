import 'instructor_student_data.dart';

class InstructorStudentList {
	bool? success;
	String? message;
	InstructorStudentData? data;

	InstructorStudentList({this.success, this.message, this.data});

	factory InstructorStudentList.fromJson(Map<String, Object?> json) {
		return InstructorStudentList(
			success: json['success'] as bool?,
			message: json['message'] as String?,
			data: json['data'] == null
						? null
						: InstructorStudentData.fromJson(json['data']! as Map<String, Object?>),
		);
	}



	Map<String, Object?> toJson() => {
				'success': success,
				'message': message,
				'data': data?.toJson(),
			};
}
