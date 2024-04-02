class MyCourse {
	int? id;
	String? thumbnail;
	String? title;
	int? totalLessons;
	int? completedLessons;
	String? completedPercentage;

	MyCourse({
		this.id, 
		this.thumbnail, 
		this.title, 
		this.totalLessons, 
		this.completedLessons, 
		this.completedPercentage, 
	});

	factory MyCourse.fromJson(Map<String, Object?> json) => MyCourse(
				id: json['id'] as int?,
				thumbnail: json['thumbnail'] as String?,
				title: json['title'] as String?,
				totalLessons: json['total_lessons'] as int?,
				completedLessons: json['completed_lessons'] as int?,
				completedPercentage: json['completed_percentage'].toString(),
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'thumbnail': thumbnail,
				'title': title,
				'total_lessons': totalLessons,
				'completed_lessons': completedLessons,
				'completed_percentage': completedPercentage,
			};
}
