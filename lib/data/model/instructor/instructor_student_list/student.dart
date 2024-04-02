class Student {
	int? id;
	String? name;
	String? image;

	Student({this.id, this.name, this.image});

	factory Student.fromJson(Map<String, Object?> json) => Student(
				id: json['id'] as int?,
				name: json['name'] as String?,
				image: json['image'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'name': name,
				'image': image,
			};
}
