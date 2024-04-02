import 'student.dart';

class InstructorStudentData {
	List<Student>? students;

	InstructorStudentData({this.students});

	factory InstructorStudentData.fromJson(Map<String, Object?> json) => InstructorStudentData(
				students: (json['students'] as List<dynamic>?)
						?.map((e) => Student.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'students': students?.map((e) => e.toJson()).toList(),
			};
}
