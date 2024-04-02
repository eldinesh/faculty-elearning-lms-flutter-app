class Slider {
	int? id;
	int? courseID;
	String? title;
	String? subTitle;
	String? btnText;
	String? type;
	dynamic url;
	dynamic courseBookId;
	String? image;

	Slider({
		this.id, 
		this.courseID,
		this.title,
		this.subTitle, 
		this.btnText, 
		this.type, 
		this.url,
		this.courseBookId,
		this.image,
	});

	factory Slider.fromJson(Map<String, Object?> json) => Slider(
				id: json['id'] as int?,
				courseID: json['course_id'] as int?,
				title: json['title'] as String?,
				subTitle: json['sub_title'] as String?,
				btnText: json['btn_text'] as String?,
				type: json['type'] as String?,
				url: json['url'] as String?,
				courseBookId: json['course_book_id'] as int?,
				image: json['image'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'course_id': id,
				'title': title,
				'sub_title': subTitle,
				'btn_text': btnText,
				'type': type,
				'url': url,
				'course_book_id': courseBookId,
				'image': image,
			};
}
