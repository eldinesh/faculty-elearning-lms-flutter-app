import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/data/model/assignment_model/assignment_model.dart';
import 'package:lms_user_app/repository/assignment_repository.dart';

class AssignmentController extends GetxController implements GetxService {
  bool isAssignmentListLoading = false;

  final List<Assignments> _assignmentList = [];
  List<Assignments> get assignmentList => _assignmentList;


  late bool _isLoading = false;
  bool get isLoading => _isLoading;
  File? _file;
  File? get file=> _file;

  Future<void> clearFile() async{
    _isLoading = true;
    _file = null;
    update();
  }

  Future<void> getAssignmentList() async {
    isAssignmentListLoading = true;
    update();
    final response = await AssignmentRepository(Get.find()).getAssignmentList();
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        List<Assignments> list = AssignmentModel.fromJson(response.body).data!.assignments!;
        _assignmentList.addAll(list);
        isAssignmentListLoading = false;
      }
    }
    update();
  }


  Future<void> submitAssignment({required int? assignmentId}) async {
    final response = await AssignmentRepository(Get.find()).submitAssignment(assignmentId:assignmentId.toString(), file: file );
    if (response != null && response.statusCode == 200) {
      customSnackBar("${response.body['message']}".tr, isError: false);
    } else {
      customSnackBar(response?.body['message'] ?? "something_wrong".tr);
    }
    update(['_dialog']);
  }


  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _file = File(result.files.single.path!);
    }
    update();
  }

}
