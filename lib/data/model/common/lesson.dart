class Lesson {
  late int id;
  late String title;
  late String description;
  late String type;
  String? duration;
  late bool isFree;
  late String thumbnail;
  late dynamic link;

  Lesson(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      this.duration,
      required this.isFree,
      required this.thumbnail,
      required this.link});

  factory Lesson.fromJson(Map<String, Object?> json) => Lesson(
      id: json['id'] as int,
      title: json['title'] as String,
      description:
          json['description'] != null ? json['description'] as String : '',
      type: json['type'] as String,
      duration: json['duration'] as String?,
      isFree: json['is_free'] as bool,
      thumbnail: json['thumbnail'] as String,
      link: json['link'] as String);

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'type': type,
        'duration': duration,
        'is_free': isFree,
        'thumbnail': 'thumbnail',
        'link': 'link'
      };
}
