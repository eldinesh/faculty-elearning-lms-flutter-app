import 'package:get/get.dart';
import 'package:lms_user_app/data/model/on_board/on_board_model.dart';
import 'package:lms_user_app/repository/on_board_repository.dart';

class OnBoardController extends GetxController implements GetxService {
  final OnBoardRepository repository;
  OnBoardController({required this.repository});

  final List<OnBoardData> _onBoardList = [];
  List<OnBoardData> get myCourseList => _onBoardList;
  bool _isMyCourseDataLoading = false;
  bool get isMyCourseLoading => _isMyCourseDataLoading;

  Future<void> getOnBoardList() async {
    _isMyCourseDataLoading = true;
    update();
    final response = await repository.getOnBoardData();
    if (response != null && response.statusCode == 200) {
      if (response.body['success']) {
        OnBoardModel list = OnBoardModel.fromJson(response.body);
        _onBoardList.clear();
        _onBoardList.addAll(list.data!.onBoards!);
      }
    }
    _isMyCourseDataLoading = false;
    update();
  }
}
