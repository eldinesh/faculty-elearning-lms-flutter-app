import '../../common/section.dart';

class Data {
	List<Section>? sections;

	Data({this.sections});

	factory Data.fromJson(Map<String, Object?> json) => Data(
				sections: (json['sections'] as List<dynamic>?)
						?.map((e) => Section.fromJson(e as Map<String, Object?>))
						.toList(),
			);

	Map<String, Object?> toJson() => {
				'sections': sections?.map((e) => e.toJson()).toList(),
			};
}
