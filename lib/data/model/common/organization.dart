class Organization {
  int? id;
  String? name;
  String? tagline;
  String? logo;

  Organization({this.id, this.name, this.tagline, this.logo});

  factory Organization.fromJson(Map<String, Object?> json) => Organization(
        id: json['id'] as int?,
        name: json['name'] as String?,
        tagline: json['tagline'] as String?,
        logo: json['logo'] as String?,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'tagline': tagline,
        'logo': logo,
      };
}
