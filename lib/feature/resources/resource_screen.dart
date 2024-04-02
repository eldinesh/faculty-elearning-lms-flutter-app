import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/resource_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourceScreen extends StatelessWidget {
  final String courseID;
  const ResourceScreen({Key? key, required this.courseID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'course_resource'.tr,
      ),
      body: GetBuilder<ResourceController>(
        initState: (state) => Get.find<ResourceController>().getResourceList(courseID),
        builder: (controller) {
          return controller.isResourceListLoading ? const LoadingIndicator()
              : controller.assignmentList.isEmpty  ?
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.emptyResource,scale: 3,),
                const SizedBox(height: Dimensions.paddingSizeDefault,),
                Text('no_resource_available_yet'.tr),
              ],
            ),
          ): mainUI(controller);
        },
      ),
    );
  }


  Widget mainUI(ResourceController resourceController){
    return ListView.builder(
        itemCount: resourceController.assignmentList.length,
        itemBuilder: (context, index) {
          DateTime startDate = DateTime.parse(resourceController.assignmentList.elementAt(index).createdAt!);

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
                        child: Text(resourceController.assignmentList.elementAt(index).title!.substring(0,1)),
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
                                resourceController.assignmentList.elementAt(index).title!,
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color,
                                    fontSize: Dimensions.fontSizeDefault),
                              ),
                              Text(
                                DateFormat.yMMMMd().format(startDate),
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: (){
                              _launchUrl(Uri.parse(resourceController.assignmentList.elementAt(index).source!));
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
                                  "view_details".tr,
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
