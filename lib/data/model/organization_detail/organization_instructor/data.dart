
import '../../common/instructor.dart';

class Data {
	List<Instructor>? instructors;

	Data({this.instructors});

	factory Data.fromJson(Map<String, Object?> json) => Data(
				instructors: (json['instructors'] as List<dynamic>?)
						?.map((e) => Instructor.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'instructors': instructors?.map((e) => e.toJson()).toList(),
			};
}
