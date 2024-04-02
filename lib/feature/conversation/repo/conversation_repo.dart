import 'package:get/get_connect/http/src/response/response.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';

class ConversationRepo {
  final ApiClient apiClient;
  ConversationRepo({required this.apiClient});

  Future<Response> createChannel(String userID,String referenceID) async {
    return await apiClient.postData(AppConstants.createChannel, {"to_user": userID,"reference_id":referenceID, "reference_type":"booking_id"});
  }

  Future<Response> getChannelList(int offset) async {
    return await apiClient.getData('${AppConstants.getChannelList}offset=$offset');
  }

  Future<Response> getChannelListBasedOnReferenceId(int offset,String referenceID) async {
    return await apiClient.getData('${AppConstants.getChannelList}offset=$offset&reference_id=$referenceID&reference_type=booking_id');
  }

  Future<Response> getConversation(String channelID,int offset) async {
    return await apiClient.getData('${AppConstants.getConversation}?channel_id=$channelID&offset=$offset');
  }

/*  Future<Response> sendMessage(String message,String channelID,  List<MultipartBody> file, PlatformFile? platformFile) async {
    return await apiClient.postMultipartDataConversation(
        AppConstants.sendMessage,
        {"message": message,"channel_id" : channelID},
        file ,
        otherFile: platformFile
    );
  }*/
}