import '../common/category.dart';
import '../common/course.dart';
import '../common/instructor.dart';
import '../common/my_course.dart';
import 'slider.dart';

class HomeData {
  String? sectionType;
  List<Slider>? sliders;
  List<MyCourse>? myCourses;
  List<Category>? categories;
  List<Course>? topCourses;
  List<Instructor>? instructors;
  List<Course>? featuredCourses;
  List<Course>? offerCourses;

  HomeData({
    this.sectionType,
    this.sliders,
    this.myCourses,
    this.categories,
    this.topCourses,
    this.instructors,
    this.featuredCourses,
    this.offerCourses,
  });

  factory HomeData.fromJson(Map<String, Object?> json) => HomeData(
        sectionType: json['section_type'] as String?,
        sliders: (json['sliders'] as List<dynamic>?)
            ?.map((e) => Slider.fromJson(e as Map<String, Object?>))
            .toList(),
        myCourses: (json['my_courses'] as List<dynamic>?)
            ?.map((e) => MyCourse.fromJson(e as Map<String, Object?>))
            .toList(),
        categories: (json['categories'] as List<dynamic>?)
            ?.map((e) => Category.fromJson(e as Map<String, Object?>))
            .toList(),
        topCourses: (json['top_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
        instructors: (json['instructors'] as List<dynamic>?)
            ?.map((e) => Instructor.fromJson(e as Map<String, Object?>))
            .toList(),
        featuredCourses: (json['featured_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
        offerCourses: (json['offer_courses'] as List<dynamic>?)
            ?.map((e) => Course.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'section_type': sectionType,
        'sliders': sliders?.map((e) => e.toJson()).toList(),
        'my_courses': myCourses?.map((e) => e.toJson()).toList(),
        'categories': categories?.map((e) => e.toJson()).toList(),
        'top_courses': topCourses?.map((e) => e.toJson()).toList(),
        'instructors': instructors?.map((e) => e.toJson()).toList(),
        'featured_courses': featuredCourses?.map((e) => e.toJson()).toList(),
        'offer_courses': offerCourses?.map((e) => e.toJson()).toList(),
      };
}
