import 'package:get/get.dart';
import 'package:lms_user_app/data/model/conversation/all_messages.dart';
import 'package:lms_user_app/data/model/conversation/chat_list.dart';
import 'package:lms_user_app/repository/chat_repository.dart';

class ChatController extends GetxController implements GetxService {
  bool isLoadingInstructorsList = false;
  List<ConversationUser> chatList = [];

  final List<MessageData> _messageList = [];
  List<MessageData> get messageList => _messageList;

  Future<void> getInstructorsList() async {
    isLoadingInstructorsList = true;
    update();
    final response = await ChatRepository(Get.find()).getConversationList();
    if (response != null && response.statusCode == 200) {
      ChatList data = ChatList.fromJson(response.body);
      chatList.clear();
      chatList.addAll(data.data!);
    }

    isLoadingInstructorsList = false;
    update();
  }
}
