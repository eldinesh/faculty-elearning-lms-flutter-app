class Slider {
	int? id;
	String? title;
	String? subTitle;
	String? btnText;
	dynamic type;
	int? btnLink;
	String? image;

	Slider({
		this.id, 
		this.title, 
		this.subTitle, 
		this.btnText, 
		this.type, 
		this.btnLink, 
		this.image, 
	});

	factory Slider.fromJson(Map<String, Object?> json) => Slider(
				id: json['id'] as int?,
				title: json['title'] as String?,
				subTitle: json['sub_title'] as String?,
				btnText: json['btn_text'] as String?,
				type: json['type'] as dynamic,
				btnLink: json['btn_link'] as int?,
				image: json['image'] as String?,
			);

	Map<String, Object?> toJson() => {
				'id': id,
				'title': title,
				'sub_title': subTitle,
				'btn_text': btnText,
				'type': type,
				'btn_link': btnLink,
				'image': image,
			};
}
