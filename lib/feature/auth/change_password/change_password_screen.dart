import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/loading_indicator.dart';
import '../../../utils/images.dart';
import '../../../utils/styles.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final GlobalKey<FormState> changePassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'changePassword'.tr,
        centerTitle: false,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color!,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: GetBuilder<AuthController>(builder: (controller) {
          return Stack(
            children: [
              mainUI(context, controller),
              controller.isLoading
                  ? const LoadingIndicator()
                  : const SizedBox(),
            ],
          );
        }),
      ),
    );
  }

  mainUI(BuildContext context, AuthController controller) {
    return Form(
        key: changePassKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('change_your_password'.tr,
                    style: robotoRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.8))),
                const SizedBox(height: 20),
                passwordField(
                    context,
                    controller.currentPasswordControllerForChangePasswordScreen,
                    'current_password'.tr),
                const SizedBox(height: 20),
                passwordField(
                    context,
                    controller.newPasswordControllerForChangePasswordScreen,
                    'new_password'.tr),
                const SizedBox(height: 20),
                passwordField(
                    context,
                    controller.confirmPasswordControllerForChangePasswordScreen,
                    'confirm_password'.tr),
                //const Spacer(),
              ],
            ),
            CustomButton(
                onPressed: () => controller.resetPassword(),
                buttonText: 'save_and_change'.tr),
          ],
        ));
  }

  Widget passwordField(BuildContext context,
      TextEditingController textController, String hintText) {
    return GetBuilder<AuthController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.06)),
              borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.paddingSizeExtraSmall)),
            ),
            child: CustomTextField(
              hintText: hintText,
              controller: textController,
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.only(right: Dimensions.paddingSizeDefault),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.paddingSizeDefault,
                    top: Dimensions.paddingSizeDefault,
                    bottom: Dimensions.paddingSizeDefault,
                  ),
                  child: SvgPicture.asset(
                    Images.lock,
                  ),
                ),
              ),
              isPassword: true,
            ),
          ),
        ],
      );
    });
  }
}
