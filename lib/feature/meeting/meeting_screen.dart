import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/meeting_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class MeetingScreen extends StatelessWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'meeting_list'.tr,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      body: GetBuilder<MeetingController>(
        initState: (state) => Get.find<MeetingController>().getMeetingList(),
        builder: (controller) {
          return controller.isMeetingListLoading ? const LoadingIndicator()
              : controller.meetingList.isEmpty  ?
          Center(
                child: Text('you_dont_have_any_meeting_yet'.tr),
              ): mainUI(controller);
        },
      ),
    );
  }


  Widget mainUI(MeetingController meetingController){

    return ListView.builder(
        itemCount: meetingController.meetingList.length,
        itemBuilder: (context, index) {
          DateTime dateTime = DateTime.parse(meetingController.meetingList.elementAt(index).startAt ?? DateTime.now().toString());

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),
                border: Border.all(color: Theme.of(context).primaryColorLight),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                      child: CircleAvatar(
                        backgroundColor: randomColorPicker(),
                        radius: 20,
                        child: Text(meetingController.meetingList.elementAt(index).title!.substring(0,1)),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                meetingController.meetingList.elementAt(index).title!,
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color,
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              Text(
                                DateFormat.yMMMMd().format(dateTime),
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              _launchUrl(Uri.parse(meetingController.meetingList.elementAt(index).meetingLink!));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusSmall)),),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.paddingSizeSmall,
                                    vertical: Dimensions.paddingSizeMint),
                                child: Text(
                                  "join".tr,
                                  style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

}
