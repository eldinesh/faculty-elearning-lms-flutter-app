import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/data/model/instructor/instructor_profile.dart';
import 'package:lms_user_app/data/model/instructor/instructor_student_list/instructor_student_list.dart';
import 'package:lms_user_app/repository/instructor_repository.dart';

import '../data/model/common/course.dart';
import '../data/model/instructor/instructor_course_list/instructor_course_list.dart';
import '../data/model/instructor/instructor_student_list/student.dart';

class InstructorController extends GetxController implements GetxService {
  final InstructorRepository repository;
  InstructorController({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late InstructorProfile _instructorProfile;
  InstructorProfile get instructorProfile => _instructorProfile;
  bool followingUnfollowing = false;

  //course
  int _coursePageNumber = 1;
  final List<Course> _instructorCourseList = [];
  List<Course> get instructorCourseList => _instructorCourseList;
  bool _isCourseListDataLoading = false;
  bool get isCourseListLoading => _isCourseListDataLoading;
  final ScrollController courseListScrollController = ScrollController();
  //student list
  int _studentPageNumber = 1;
  final List<Student> _instructorStudentList = [];
  List<Student> get instructorStudentList => _instructorStudentList;
  bool _isStudentListDataLoading = false;
  bool get isStudentListLoading => _isStudentListDataLoading;
  final ScrollController studentListScrollController = ScrollController();

  bool _isFollowing = false;
  bool get isFollowing => _isFollowing;

  @override
  void dispose() {
    courseListScrollController.dispose();
    studentListScrollController.dispose();
    super.dispose();
  }

  Future<void> getInstructorProfile(int id) async {
    _isLoading = true;
    update();
    final response = await repository.getInstructorProfile(id);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        InstructorProfile profile = InstructorProfile.fromJson(response.body);
        _instructorProfile = profile;
        _isFollowing = _instructorProfile.data!.isFollowing;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body['message'] ?? 'something_wrong'.tr);
    }
    _isLoading = false;
    update();
  }

  Future<void> getInstructorCourseList(int id) async {
    _isCourseListDataLoading = true;
    update();
    final response = await repository.getCourseListOfInstructors(
        id: id, page: _coursePageNumber);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        InstructorCourseList list =
            InstructorCourseList.fromJson(response.body);
        _instructorCourseList.addAll(list.data!.courses!);

        if (list.data!.courses!.isNotEmpty) {
          _coursePageNumber++;
        }
      }
    }
    _isCourseListDataLoading = false;
    update();
  }

  Future<void> getInstructorsStudentList(int id) async {
    _isStudentListDataLoading = true;
    update();
    final response =
        await repository.getStudentsList(id: id, page: _studentPageNumber);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        InstructorStudentList list =
            InstructorStudentList.fromJson(response.body);
        _instructorStudentList.addAll(list.data!.students!);
        if (list.data!.students!.isNotEmpty) {
          _studentPageNumber++;
        }
      }
    }
    _isStudentListDataLoading = false;
    update();
  }

  Future<void> followUnfollow(int id) async {
    followingUnfollowing = true;
    update();
    final response = await repository.followUnfollow(id);
    if (response != null && response.statusCode == 200) {
      printLog("---follow unfollow response: ${response.body['success']}");
      if (response.body['success'] == true) {
        _isFollowing = !_isFollowing;
      }
    }
    followingUnfollowing = false;
    update();
  }
}
