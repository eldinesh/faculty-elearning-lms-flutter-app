class OrganizationDetail {
  bool? success;
  String? message;
  OrganizationProfileData? data;

  OrganizationDetail({this.success, this.message, this.data});

  factory OrganizationDetail.fromJson(Map<String, Object?> json) {
    return OrganizationDetail(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : OrganizationProfileData.fromJson(
              json['data']! as Map<String, Object?>),
    );
  }

  Map<String, Object?> toJson() => {
        'success': success,
        'message': message,
        'data': data?.toJson(),
      };
}

class OrganizationProfileData {
  String? id;
  String? name;
  String? address;
  String? rating;
  int? totalReview;
  String? brandColor;
  String? phone;
  String? email;
  int? totalCourse;
  int? totalInstructor;
  int? totalStudents;
  int? totalEnrollments;
  String? logo;

  OrganizationProfileData({
    this.id,
    this.name,
    this.address,
    this.rating,
    this.totalReview,
    this.brandColor,
    this.phone,
    this.email,
    this.totalCourse,
    this.totalInstructor,
    this.totalStudents,
    this.totalEnrollments,
    this.logo, 
  });

  factory OrganizationProfileData.fromJson(Map<String, Object?> json) =>
      OrganizationProfileData(
        id: json['id'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?,
        rating: json['rating'] as String?,
        totalReview: json['total_review'] as int?,
        brandColor: json['brand_color'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
        totalCourse: json['total_course'] as int?,
        totalInstructor: json['total_instructor'] as int?,
        totalStudents: json['total_students'] as int?,
        totalEnrollments: json['total_enrollments'] as int?,
        logo: json['logo'] as String?
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'rating': rating,
        'total_review': totalReview,
        'brand_color': brandColor,
        'phone': phone,
        'email': email,
        'total_course': totalCourse,
        'total_instructor': totalInstructor,
        'total_students': totalStudents,
        'total_enrollments': totalEnrollments,
        'logo': logo, 
      };
}
