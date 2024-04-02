class CourseModel {
  bool? success;
  String? message;
  ServiceContent? content;

  CourseModel({this.success, this.message, this.content});

  CourseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    content = json['data'] != null ? ServiceContent.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (content != null) {
      data['data'] = content!.toJson();
    }
    return data;
  }
}

class ServiceContent {
  List<Course>? courses;

  ServiceContent({this.courses});

  ServiceContent.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Course>[];
      json['courses'].forEach((v) {
        courses!.add(Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int? id;
  String? thumbnail;
  String? title;
  int? totalLessons;
  int? totalEnrolls;
  bool? isFree;
  String? totalRating;
  String? price;
  bool? isDiscounted;
  String? discountType;
  String? discountedPrice;

  Course(
      {this.id,
      this.thumbnail,
      this.title,
      this.totalLessons,
      this.totalEnrolls,
      this.isFree,
      this.totalRating,
      this.price,
      this.isDiscounted,
      this.discountType,
      this.discountedPrice});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    title = json['title'];
    totalLessons = json['total_lessons'];
    totalEnrolls = json['total_enrolls'];
    isFree = json['is_free'];
    totalRating = json['total_rating'];
    price = json['price'];
    isDiscounted = json['is_discounted'];
    discountType = json['discount_type'];
    discountedPrice = json['discounted_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumbnail'] = thumbnail;
    data['title'] = title;
    data['total_lessons'] = totalLessons;
    data['total_enrolls'] = totalEnrolls;
    data['is_free'] = isFree;
    data['total_rating'] = totalRating;
    data['price'] = price;
    data['is_discounted'] = isDiscounted;
    data['discount_type'] = discountType;
    data['discounted_price'] = discountedPrice;
    return data;
  }
}
