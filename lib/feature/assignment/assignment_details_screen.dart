import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/controller/assignment_controller.dart';
import 'package:lms_user_app/data/model/assignment_model/assignment_model.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:path/path.dart' as path;

class AssignmentDetailsScreen extends StatelessWidget {
  final Assignments? assignments;

  const AssignmentDetailsScreen({Key? key, required this.assignments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime deadline = DateTime.parse(assignments!.deadline!);

    return Scaffold(
        appBar: CustomAppBar(
          title: 'my_assignment'.tr,
        ),
        body: GetBuilder<AssignmentController>(
          initState: (state){
            WidgetsBinding.instance.addPostFrameCallback((_){
              Get.find<AssignmentController>().clearFile();
            });
          },
          builder: (assignmentController) {
            if(assignmentController.isLoading) {
              return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: Get.height,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall,),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("assignment_title".tr, style: robotoMedium,),
                    Text(assignments!.title!),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    Text("total_mark".tr, style: robotoMedium,),
                    Text(assignments!.totalMarks.toString()),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    Text("pass_mark".tr, style: robotoMedium,),
                    Text(assignments!.passMarks.toString()),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    Text("deadline".tr,),
                    Text(
                      DateFormat.yMMMMd().format(deadline),
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6),
                          fontSize: Dimensions.fontSizeDefault),
                    ),

                    Html(
                      data: assignments!.description!,
                      style: {
                        "p": Style(
                          fontSize: FontSize.medium,
                        ),
                      },
                    ),
                    CustomButton(
                      onPressed: () {
                        Get.find<AssignmentController>().pickFile();
                      },
                      buttonText: 'pick_file'.tr,),

                    if(assignmentController.file != null)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: Dimensions.paddingSizeDefault,),
                          Text(path.basename(Get.find<AssignmentController>().file!.path,),
                            style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                          ),),
                          const SizedBox(height: Dimensions.paddingSizeDefault,),
                          CustomButton(
                              onPressed: () {
                                Get.find<AssignmentController>().submitAssignment(
                                    assignmentId: assignments!.id);
                              },
                              buttonText: 'submit_assignment'.tr),
                        ],
                      ),

                    const SizedBox(),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),
                    const SizedBox(height: Dimensions.paddingSizeDefault,),

                  ],
                ),
              ),
            );
            }
            return const SizedBox();
          },
        )
    );
  }


  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
