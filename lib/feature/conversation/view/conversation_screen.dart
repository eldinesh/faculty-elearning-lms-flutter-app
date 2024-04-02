import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lms_user_app/controller/localization_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/conversation/all_messages.dart';
import 'package:lms_user_app/data/model/conversation/chat_list.dart';
import 'package:lms_user_app/feature/conversation/widgets/chat_app_bar.dart';
import 'package:lms_user_app/feature/conversation/widgets/input_widget.dart';
import 'package:lms_user_app/feature/conversation/widgets/video_message_builder.dart';
import 'package:lms_user_app/repository/chat_repository.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/chat_shimmer_loader.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ConversationScreen> with TickerProviderStateMixin {
  late ConversationUser chatUser;
  List<types.Message> _messages = [];
  int _page = 1;
  late types.User _user;
  late types.User _receiver;
  final GlobalKey<ChatState> _chatKey = GlobalKey();
  final TextEditingController inputController = TextEditingController();
  bool isMessageSending = false;
  late Timer _timer;

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed() async {
    if (inputController.text.isEmpty) return;
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: inputController.text.trim(),
    );
    inputController.clear();
    await ChatRepository(Get.find()).sendMessage(receiverId: _receiver.id, textMessage: textMessage);
    _addMessage(textMessage);
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.VideoMessage) {
      Navigator.pushNamed(context, RouteHelper.videoPlayerScreen, arguments: message.uri);
    }
    if (message is types.FileMessage) {
      var localPath = message.uri;
      if (message.uri.startsWith('http')) {
        try {
          // Update tapped file message to show loading spinner
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });

          final client = http.Client();
          final request = await client.get(Uri.parse(message.uri));
          final bytes = request.bodyBytes;
          final documentsDir = (await getApplicationDocumentsDirectory()).path;
          localPath = '$documentsDir/${message.name}';

          if (!File(localPath).existsSync()) {
            final file = File(localPath);
            await file.writeAsBytes(bytes);
          }
        } finally {
          // In case of error or success, reset loading spinner
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          setState(() {
            _messages[index] = updatedMessage;
          });
        }
      }
      await OpenFilex.open(localPath);
    }
  }

  // For the testing purposes, you should probably use https://pub.dev/packages/uuid.
  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      //maxWidth: 1440,
      maxWidth: 200,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
      await ChatRepository(Get.find()).sendFile(receiverId: _receiver.id, file: File(result.path));
      _hideBottomSheet();
    }
  }

  //oepn camera
  void _handleCameraSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      //maxWidth: 1440,
      maxWidth: 200,
      source: ImageSource.camera,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: randomString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
      await ChatRepository(Get.find()).sendFile(receiverId: _receiver.id, file: File(result.path));
      _hideBottomSheet();
    }
  }

  //handle file inout
  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );
      setState(() {
        isMessageSending = true;
      });
      _addMessage(message);
      await ChatRepository(Get.find()).sendFile(receiverId: _receiver.id, file: File(result.files.single.path!));
      _hideBottomSheet();
      setState(() {
        isMessageSending = false;
      });
    }
  }

  void _handlePreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  Future<void> _handleEndReached() async {
    final response = await ChatRepository(Get.find()).getAllMessages(chatRoomId: chatUser.chatRoomId, page: _page);
    if (response == null) return;
    _processMessages(response);
  }

  types.Message _processMessageByType(MessageData e) {
    if (e.isFile!) {
      if (e.isImage!) {
        return types.ImageMessage(
            author: e.type == "1" ? _receiver : _user,
            id: e.id.toString(),
            name: e.message ?? "",
            uri: e.fileUrl!,
            createdAt: e.createdAt?.millisecondsSinceEpoch,
            size: getFileSize(e.fileSize ?? "0 KB"),
            type: types.MessageType.image);
      } else if (e.isVideo!) {
        return types.VideoMessage(
            author: e.type == "1" ? _receiver : _user,
            id: e.id.toString(),
            name: e.message ?? "",
            uri: e.fileUrl!,
            createdAt: e.createdAt?.millisecondsSinceEpoch,
            size: getFileSize(e.fileSize ?? "0 KB"),
            type: types.MessageType.video);
      } else {
        return types.FileMessage(
            author: e.type == "1" ? _receiver : _user,
            id: e.id.toString(),
            name: e.message ?? "",
            createdAt: e.createdAt?.millisecondsSinceEpoch,
            uri: e.fileUrl!,
            size: getFileSize(e.fileSize ?? "0 KB"),
            type: types.MessageType.file);
      }
    } else {
      return types.TextMessage(
          author: e.type == "1" ? _receiver : _user,
          id: e.id.toString(),
          createdAt: e.createdAt?.millisecondsSinceEpoch,
          text: e.message ?? "");
    }
  }

  void _processMessages(List<MessageData> messegeData) {
    final messages = messegeData.reversed.map((e) {
      return _processMessageByType(e);
    }).toList();
    setState(() {
      _messages = [..._messages, ...messages];
      _page = _page + 1;
    });
  }

  num getFileSize(String value) {
    var size = value.split(' ')[0];
    return double.parse(size) * 1048576;
  }

  @override
  void initState() {
    super.initState();
    chatUser = Get.arguments;

    _user = types.User(id: randomString());
    _receiver = types.User(id: chatUser.userId.toString());
    _handleEndReached();
    startTimer();
  }

  void startTimer() async {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      final response = await ChatRepository(Get.find()).getAllMessages(chatRoomId: chatUser.chatRoomId, page: 1);

      if (response != null) {
        if (response.last.id.toString() != _messages.first.id && response.last.type != '2') {
          //type 2 means this message is send by Seller
          _addMessage(_processMessageByType(response.last));
        }
      }
    });
  }

  @override
  void dispose() {
    inputController.dispose();
    _timer.cancel();
    super.dispose();
  }

  _hideBottomSheet() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatAppBar(
          user: chatUser,
        ),
        body: Chat(
          key: _chatKey,
          messages: _messages,
          emptyState: const ChatShimmerLoader(),
          onSendPressed: (p0) {},
          user: _user,
          bubbleRtlAlignment:Get.find<LocalizationController>().isLtr ?  BubbleRtlAlignment.left : BubbleRtlAlignment.right,
          onMessageTap: _handleMessageTap,
          dateFormat: DateFormat('MMM d, yyyy'),
          dateIsUtc: false,
          // timeFormat: DateFormat.yMMMd().add_jms(),
          timeFormat: DateFormat().add_jm(),
          videoMessageBuilder: (message, {required messageWidth}) {
            return VideoMessagePreview(
              videoUrl: message.uri,
            );
          },
          imageMessageBuilder: (imageMesage, {required messageWidth}) {
            return SizedBox(
              width: 200,
              height: 250,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: imageMesage.uri.startsWith("http")
                    ? Image.network(
                  imageMesage.uri,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                )
                    : Image.file(
                  File(imageMesage.uri),
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            );
          },
          onAttachmentPressed: _handleFileSelection,
          onPreviewDataFetched: _handlePreviewDataFetched,
          usePreviewData: true,
          textMessageOptions: const TextMessageOptions(
            isTextSelectable: true,
          ),
          bubbleBuilder: (child, {required message, required nextMessageInGroup}) {
            return message.author.id == _receiver.id
                ? Container(
              decoration: const BoxDecoration(
                color: Color(0x0f23A462),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: child,
            )
                : Container(
              decoration: const BoxDecoration(
                color: Color(0x0f23A462),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: child,
            );
          },
          theme: DefaultChatTheme(
            sentMessageCaptionTextStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 10,
              color: const Color(0xff999999),
            ),
            sentMessageDocumentIconColor: Colors.black,
            sentMessageBodyTextStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              color: const Color(0xff333333),
            ),
            receivedMessageBodyTextStyle:
            Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              color: const Color(0xff333333),
            ),
          ),
          onEndReached: _handleEndReached,
          isAttachmentUploading: isMessageSending,
          customBottomWidget: InputWidget(
            inputController: inputController,
            onSendPressed: _handleSendPressed,
            onAttatchmentButtonPressed: _handleFileSelectionSheet,
          ),
          scrollToUnreadOptions: const ScrollToUnreadOptions(
            lastReadMessageId: 'lastReadMessageId',
            scrollOnOpen: true,
          ),
          inputOptions: const InputOptions(
              sendButtonVisibilityMode: SendButtonVisibilityMode.always),
        ));
  }

  // file chooser bottom sheet
  void _handleFileSelectionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 130,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _iconButton(
                    iconName: "camera",
                    title: 'camera'.tr,
                    onPressed: _handleCameraSelection),
                _iconButton(
                    iconName: "gallery",
                    title: 'gallery'.tr,
                    onPressed: _handleImageSelection),
                _iconButton(
                    iconName: "file",
                    title: 'file'.tr,
                    onPressed: _handleFileSelection),
              ],
            ),
          ),
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      backgroundColor: Colors.white,
      isDismissible: true,
      useRootNavigator: true,
      elevation: 4,
      transitionAnimationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 600)),
      enableDrag: true,
    );
  }

  Widget _iconButton(
      {required String iconName,
        required String title,
        required Function() onPressed}) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(23),
          child: Container(
            height: 46,
            width: 46,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0x0f23A462),
            ),
            child: SvgPicture.asset(
              "assets/icons/chat/$iconName.svg",
              height: 18,
              width: 22,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 12, color: const Color(0xff666666)),
          ),
        )
      ],
    );
  }
}
