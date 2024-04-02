class SocialLink {
  late String name;
  late String link;

  SocialLink({this.name = "", this.link = ''});

  factory SocialLink.fromJson(Map<String, Object?> json) => SocialLink(
        name: json['name'] != null ? json['name'] as String : '',
        link: json['link'] != null ? json['link'] as String : '',
      );

  Map<String, Object?> toJson() => {
        'name': name,
        'link': link,
      };
}
