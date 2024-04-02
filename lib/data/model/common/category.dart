
class Category {
  int? id;
  String? title;
  String? icon;
  int? totalCourses;

  Category({this.id, this.title, this.icon, this.totalCourses});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    icon = json['icon'];
    totalCourses = json['total_courses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['icon'] = icon;
    data['total_courses'] = totalCourses;
    return data;
  }
}
