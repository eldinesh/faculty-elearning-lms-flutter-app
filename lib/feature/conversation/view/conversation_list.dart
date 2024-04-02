import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/chat_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/conversation/chat_list.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class ConversationList extends StatelessWidget {
  const ConversationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "conversation".tr,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color!,
      ),
      body: GetBuilder<ChatController>(
          initState: (state) => Get.find<ChatController>().getInstructorsList(),
          builder: (controller) {
            return controller.isLoadingInstructorsList == true
                ? const LoadingIndicator()
                : controller.chatList.isEmpty
                    ? Center(
                        child: Text(
                        "no_conversation_found".tr,
                        style: robotoRegular,
                      ))
                    : ListView.builder(
                        itemCount: controller.chatList.length,
                        itemBuilder: (context, index) {
                          return chatItem(
                              index, context, controller.chatList[index]);
                        });
          }),
    );
  }

  Padding chatItem(int index, BuildContext context, ConversationUser data) {
    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.paddingSizeDefault,
        right: Dimensions.paddingSizeDefault,
        bottom: Dimensions.paddingSizeExtraSmall,
        top: index != 0
            ? Dimensions.paddingSizeExtraSmall
            : Dimensions.paddingSizeDefault,
      ),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06),
              width: 1),
          borderRadius:
              const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(RouteHelper.conversationScreen, arguments: data);
          },
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                        child: Image.network(
                      data.logo ?? '',
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(Images.placeholder),
                    )),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.userName,
                        style: robotoMedium.copyWith(
                            color:
                                Theme.of(context).textTheme.bodyLarge!.color!,
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                      const SizedBox(
                        height: Dimensions.paddingSizeSmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data.message.message ?? '',
                              style: robotoRegular.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color!
                                      .withOpacity(0.6),
                                  fontSize: Dimensions.fontSizeExtraSmall)),
                          Text(
                            data.message.createdAt ?? '',
                            style: robotoRegular.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.6),
                                fontSize: Dimensions.fontSizeExtraSmall),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
