class Instructor {
	int? id;
	String? name;
	String? image;
	String? instructor;
	String? about;

	Instructor({this.id, this.name, this.image, this.instructor, this.about});

	factory Instructor.fromJson(Map<String, Object?> json) => Instructor(
				id: json['id'] as int?,
				name: json['name'] as String?,
				image: json['image'] as String?,
				instructor: json['instructor'] as String?,
				about: json['about'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'name': name,
				'image': image,
				'instructor': instructor,
				'about': about,
			};
}
