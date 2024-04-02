import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/data/model/common/instructor.dart';
import 'package:lms_user_app/data/model/organization_detail/organization_profile.dart';
import 'package:lms_user_app/repository/organization_repository.dart';

import '../components/custom_snackbar.dart';
import '../data/model/instructor/instructor_course_list/instructor_course_list.dart';
import '../data/model/organization_detail/organization_instructor/organization_instructor.dart';

class OrganizationController extends GetxController implements GetxService {
  final OrganizationRepository repository;
  OrganizationController({required this.repository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late OrganizationProfileData _profileData;
  OrganizationProfileData get profileData => _profileData;

  //courses
  int _coursePageNumber = 1;
  final List<Course> _courseList = [];
  List<Course> get courseList => _courseList;
  bool _isCourseListLoading = false;
  bool get isCourseListLoading => _isCourseListLoading;
  final ScrollController courseListScrollController = ScrollController();
  // instructors
  int _instructorPageNumber = 1;
  final List<Instructor> _instructorList = [];
  List<Instructor> get instructorList => _instructorList;
  bool get isInstructorListLoading => _isCourseListLoading;
  final ScrollController instructorScrollController = ScrollController();

  Future<void> getOrganizationProfile(int id) async {
    _isLoading = true;
    update();
    final response = await repository.getOrganizationProfile(id);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        OrganizationDetail detail = OrganizationDetail.fromJson(response.body);
        _profileData = detail.data!;
      } else {
        customSnackBar(response.body['message']);
      }
    } else {
      customSnackBar(response?.body['message'] ?? 'something_wrong'.tr);
    }
    _isLoading = false;
    update();
  }

  Future<void> getCourseList(int id) async {
    _isCourseListLoading = true;
    update();
    final response =
        await repository.getOrganizationCourseList(id, _coursePageNumber);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        InstructorCourseList list =
            InstructorCourseList.fromJson(response.body);
        _courseList.addAll(list.data!.courses!);
        if (list.data!.courses!.isNotEmpty) {
          _coursePageNumber++;
        }
      }
    }
    _isCourseListLoading = false;
    update();
  }

  Future<void> getInstructorList(int id) async {
    update();
    final response = await repository.getOrganizationInstructorList(
        id, _instructorPageNumber);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        OrganizationInstructor list =
            OrganizationInstructor.fromJson(response.body);
        _instructorList.addAll(list.data!.instructors!);
        if (list.data!.instructors!.isNotEmpty) {
          _instructorPageNumber++;
        }
      }
    }
    update();
  }
}
