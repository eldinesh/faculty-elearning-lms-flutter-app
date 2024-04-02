
class Summary {
  String? description;
  String? title;
  String? author;
  String? publisher;
  String? edition;
  int? page;
  String? country;
  String? language;

  Summary({
    this.description,
    this.title,
    this.author,
    this.publisher,
    this.edition,
    this.page,
    this.country,
    this.language,
  });

  factory Summary.fromJson(Map<String, Object?> json) => Summary(
        description: json['description'] as String?,
        title: json['title'] as String?,
        author: json['author'] as String?,
        publisher: json['publisher'] as String?,
        edition: json['edition'] as String?,
        page: json['page'] as int?,
        country: json['country'] as String?,
        language: json['language'] as String?,
      );

  Map<String, Object?> toJson() => {
        'description': description,
        'title' : title, 
        'author': author,
        'publisher': publisher,
        'edition': edition,
        'page': page,
        'country': country,
        'language': language,
      };
}
