class BookInstructor {
  int? id;
  String? name;
  String? designation;
  String? image;
  String? joined;
  int? publishedBook;

  BookInstructor(
      {this.id,
      this.name,
      this.designation,
      this.image,
      this.joined,
      this.publishedBook});

  factory BookInstructor.fromJson(Map<String, Object?> json) => BookInstructor(
        id: json['id'] as int?,
        name: json['name'] as String?,
        designation: json['designation'] as String?,
        image: json['image'] as String?,
        joined: json['joined_at'] as String?,
        publishedBook: json['published_book'] as int?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'designation': designation,
        'image': image,
        'joined_at': joined,
        'published_book': publishedBook,
      };
}
