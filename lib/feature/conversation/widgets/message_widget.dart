import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/controller/localization_controller.dart';
import 'package:lms_user_app/core/helper/responsive_helper.dart';
import 'package:lms_user_app/feature/conversation/model/conversation_model.dart';
import 'package:lms_user_app/utils/dimensions.dart';


class ConversationBubble extends StatefulWidget {
  final ConversationData conversationData;
  final bool isRightMessage;
  final String oppositeName;
  final String oppositeImage;

  const ConversationBubble({
    super.key,
    required this.conversationData,
    required this.isRightMessage,
    required this.oppositeName,
    required this.oppositeImage
  });

  @override
  State<ConversationBubble> createState() => _ConversationBubbleState();
}

class _ConversationBubbleState extends State<ConversationBubble> {

  @override
  void initState() {
    super.initState();
    if( ResponsiveHelper.isMobile(Get.context)){
      ReceivePort port = ReceivePort();
      IsolateNameServer.registerPortWithName(port.sendPort, 'downloader_send_port');
      port.listen((dynamic data) {
        setState((){ });
      });

      FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
    }

  }

  @override
  void dispose() {
    if(ResponsiveHelper.isMobile(Get.context)){
      IsolateNameServer.removePortNameMapping('downloader_send_port');
    }
    super.dispose();
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }


  @override
  Widget build(BuildContext context) {

    String image = '';

    // if(widget.conversationData.user!.provider != null){
    //   print(widget.conversationData.user!.provider!.companyName!);
    //   image = "";
    // }else{
    //   image = "";
    // }

    return Column(
      crossAxisAlignment: widget.isRightMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: widget.isRightMessage
              ? const EdgeInsets.fromLTRB(20, 5, 5, 5)
              : const EdgeInsets.fromLTRB(5, 5, 20, 5),
          child: Column(
            crossAxisAlignment:
            widget.isRightMessage ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              //Name
              const Text("name"),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: widget.isRightMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  //Avater for Right
                  widget.isRightMessage ? const SizedBox() : Column(
                    children: [
                    ClipRRect(borderRadius: BorderRadius.circular(50),
                        child: CustomImage(height: 30, width: 30,
                            image: widget.oppositeImage),
                    ),
                  ],
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall,),
                  //Message body
                  Flexible(
                    child: Column(
                      crossAxisAlignment: widget.isRightMessage?CrossAxisAlignment.end:CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if(widget.conversationData.message == null) Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).hoverColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(widget.conversationData.message != null?Dimensions.paddingSizeDefault:0),
                              child: Text(widget.conversationData.message??''),
                            ),
                          ),
                        ),

                        const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10,),
                  widget.isRightMessage ?
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                      child: CustomImage(
                          height: 30,
                          width: 30,
                          image: image),
                  ) : const SizedBox(),
                ],
              ),
              //Gaps.verticalGapOf(Dimensions.PADDING_SIZE_EXTRA_SMALL),

            ],
          ),
        ),
        Padding(
            padding:Get.find<LocalizationController>().isLtr ?  widget.isRightMessage ? const EdgeInsets.fromLTRB(5, 5, 50, 5) : const EdgeInsets.fromLTRB(50, 5, 5, 5):
            const EdgeInsets.fromLTRB(50, 5, 5, 5),
            child: const Text(
                "12:34 pm",
                style: TextStyle(fontSize: 8.0),
                textDirection: TextDirection.ltr)
        ),

      ],
    );
  }
}
