import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/assignment_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class MyAssignmentScreen extends StatelessWidget {
  const MyAssignmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'my_assignment'.tr,
      ),
      body: GetBuilder<AssignmentController>(
        initState: (state) => Get.find<AssignmentController>().getAssignmentList(),
        builder: (controller) {
          return controller.isAssignmentListLoading ? const LoadingIndicator()
              : controller.assignmentList.isEmpty  ?
          const Center(
            child: Text('you_dont_have_any_assignment_yet'),
          ): mainUI(controller);
        },
      ),
    );
  }


  Widget mainUI(AssignmentController assignmentController){
    return ListView.builder(
        itemCount: assignmentController.assignmentList.length,
        itemBuilder: (context, index) {
          DateTime startDate = DateTime.parse(assignmentController.assignmentList.elementAt(index).createdAt!);

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
                        child: Text(assignmentController.assignmentList.elementAt(index).title!.substring(0,1)),
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
                                assignmentController.assignmentList.elementAt(index).title!,
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
                              Get.toNamed(RouteHelper.getAssignmentDetailsScreen(assignmentController.assignmentList.elementAt(index)));
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
}
