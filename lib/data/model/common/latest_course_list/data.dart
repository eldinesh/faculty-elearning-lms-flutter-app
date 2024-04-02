
import 'package:lms_user_app/data/model/common/course.dart';

class Data {
	List<Course>? courses;

	Data({this.courses});

	factory Data.fromJson(Map<String, Object?> json) => Data(
				courses: (json['courses'] as List<dynamic>?)
						?.map((e) => Course.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'courses': courses?.map((e) => e.toJson()).toList(),
			};
}
