
class ChatList {
  bool? success;
  String? message;
  List<ConversationUser>? data;

  ChatList({this.success, this.message, this.data});

  factory ChatList.fromJson(Map<String, Object?> json) => ChatList(
        success: json['success'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ConversationUser.fromJson(e as Map<String, Object?>))
            .toList(),
      );

  Map<String, Object?> toJson() => {
        'success': success,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}


class ConversationUser {
  late int userId;
  late String userName;
  late String userEmail;
  late int chatRoomId;
  String? logo;
  late bool hasMessage;
  late Message message;

  ConversationUser(
      {this.userId = 0,
        this.userName = "",
        this.userEmail = "",
        this.chatRoomId = 0,
        this.logo,
        this.hasMessage = false,
        required this.message});

  ConversationUser.fromJson(Map<String, dynamic> json) {
    userId = json['id'];
    userName = json['uname'];
    chatRoomId = json['chat_room_id'];
    logo = json['image'];
    hasMessage = json['has_message'];
    message = Message.fromJson(json['message']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = userId;
    data['uname'] = userName;
    data['chat_room_id'] = chatRoomId;
    data['image'] = logo;
    data['has_message'] = hasMessage;
    data['message'] = message.toJson();
    return data;
  }
}

class Message {
  String? message;
  String? fileType;
  bool? isFile;
  bool? isSeen;
  String? file;
  String? createdAt;

  Message(
      {this.message,
        this.fileType,
        this.isFile,
        this.isSeen,
        this.file,
        this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fileType = json['file_type'];
    isFile = json['is_file'];
    isSeen = json['is_seen'];
    file = json['file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['file_type'] = fileType;
    data['is_file'] = isFile;
    data['is_seen'] = isSeen;
    data['file'] = file;
    data['created_at'] = createdAt;
    return data;
  }
}
