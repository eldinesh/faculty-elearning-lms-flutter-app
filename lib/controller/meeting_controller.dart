import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/data/model/meeting_model/meeting_model.dart';
import 'package:lms_user_app/repository/meeting_repository.dart';

class MeetingController extends GetxController implements GetxService {
  bool isMeetingListLoading = false;

  List<MyMeeting> _meetingList = [];
  List<MyMeeting> get meetingList => _meetingList;

  Future<void> getMeetingList() async {
    isMeetingListLoading = true;
    _meetingList = [];
    update();
    final response = await MeetingRepository(Get.find()).getMeetingList();
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        List<MyMeeting> list = MeetingModel.fromJson(response.body).data!.myMeeting!;
        _meetingList.addAll(list);
        isMeetingListLoading = false;
      }
    }
    update();
  }

  Future<void> copyCodeToClipBoard(String code) async {
    Clipboard.setData(ClipboardData(text: code)).then((value) {
      customSnackBar('copied_to_clipboard'.tr, isError: false);
    });
  }
}
