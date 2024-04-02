import 'package:get/get.dart';
import 'package:lms_user_app/data/model/notification_model.dart';
import 'package:lms_user_app/repository/notification_repo.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo notificationRepo;
  NotificationController({required this.notificationRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final int _page = 1;
  final List<Notification> _notificationList = [];
  List<Notification> get notificationList => _notificationList;

  Future<void> getNotificationList() async {
    _isLoading = true;
    update();
    final response = await notificationRepo.getNotificationList(_page);
    if (response.statusCode == 200) {
      _notificationList.clear();
      _notificationList.addAll(NotificationModel.fromJson(response.body).data!);
    }
    _isLoading = false;
    update();
  }
}
