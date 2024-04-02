import 'package:lms_user_app/data/model/common/course.dart';

import 'common/book.dart';
import 'common/category.dart';
import 'common/instructor.dart';

class Explore {
  late bool success;
  late String message;
  Data? data;

  Explore({this.success = false, this.message = "", this.data});

  Explore.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Course>? suggestedCourses;
  List<Category>? courseCategories;
  List<Course>? featuredCourses;
  List<Course>? freeCourses;
  List<Instructor>? instructors;
  List<Course>? offeredCourses;
  List<BookModel>? books;

  Data(
      {this.suggestedCourses,
      this.courseCategories,
      this.featuredCourses,
      this.freeCourses,
      this.instructors,
      this.offeredCourses,
      this.books});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['suggested_courses'] != null) {
      suggestedCourses = <Course>[];
      json['suggested_courses'].forEach((v) {
        suggestedCourses!.add(Course.fromJson(v));
      });
    }
    if (json['course_categories'] != null) {
      courseCategories = <Category>[];
      json['course_categories'].forEach((v) {
        courseCategories!.add(Category.fromJson(v));
      });
    }
    if (json['featured_courses'] != null) {
      featuredCourses = <Course>[];
      json['featured_courses'].forEach((v) {
        featuredCourses!.add(Course.fromJson(v));
      });
    }
    if (json['free_courses'] != null) {
      freeCourses = <Course>[];
      json['free_courses'].forEach((v) {
        freeCourses!.add(Course.fromJson(v));
      });
    }
    if (json['instructors'] != null) {
      instructors = <Instructor>[];
      json['instructors'].forEach((v) {
        instructors!.add(Instructor.fromJson(v));
      });
    }
    if (json['offered_courses'] != null) {
      offeredCourses = <Course>[];
      json['offered_courses'].forEach((v) {
        offeredCourses!.add(Course.fromJson(v));
      });
    }
    if (json['books'] != null) {
      books = <BookModel>[];
      json['books'].forEach((v) {
        books!.add(BookModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (suggestedCourses != null) {
      data['suggested_courses'] =
          suggestedCourses!.map((v) => v.toJson()).toList();
    }
    if (courseCategories != null) {
      data['course_categories'] =
          courseCategories!.map((v) => v.toJson()).toList();
    }
    if (featuredCourses != null) {
      data['featured_courses'] =
          featuredCourses!.map((v) => v.toJson()).toList();
    }
    if (freeCourses != null) {
      data['free_courses'] = freeCourses!.map((v) => v.toJson()).toList();
    }
    if (instructors != null) {
      data['instructors'] = instructors!.map((v) => v.toJson()).toList();
    }
    if (offeredCourses != null) {
      data['offered_courses'] = offeredCourses!.map((v) => v.toJson()).toList();
    }
    if (books != null) {
      data['books'] = books!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



