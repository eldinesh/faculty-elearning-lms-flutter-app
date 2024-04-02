import 'dart:io';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/data/model/conversation/all_messages.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../data/provider/client_api.dart';
import '../utils/app_constants.dart';

class ChatRepository {
  final ApiClient apiClient;
  ChatRepository(this.apiClient);

  Future<Response?> getConversationList() async {
    return await apiClient.getData(AppConstants.instructorsList);
  }

  //send message
  Future<Response> sendMessage(
      {required String receiverId,
        types.ImageMessage? imageMessage,
        types.FileMessage? fileMessage,
        types.TextMessage? textMessage}) async {
    var body = <String, dynamic>{};
    if (textMessage != null) {
      body = {'receiver_id': receiverId, 'msg': textMessage.text};
    } else if (imageMessage != null) {
      body = {'receiver_id': receiverId, 'file': imageMessage.uri};
      printLog("------image message uri: ${imageMessage.uri}");
    } else if (fileMessage != null) {
      body = {'receiver_id': receiverId, 'file': fileMessage.uri};
    }

    return await apiClient.postData(AppConstants.sendMessage,  body);
  }

  Future<List<MessageData>?> getAllMessages({required int chatRoomId, required int page}) async {
     final response = await apiClient.getData('${AppConstants.allMessages}?chat_room_id=$chatRoomId&&page=$page');
     return AllMessages.fromJson(response.body).data.messages.data!;
  }

  Future<Response> sendFile({required File file, required String receiverId}) async {
    return await apiClient.postMultipartDataConversation( AppConstants.sendMessage, file, receiverId);
  }
}
