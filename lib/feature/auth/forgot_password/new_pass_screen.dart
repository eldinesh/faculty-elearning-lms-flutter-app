import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../utils/images.dart';

class NewPassScreen extends StatefulWidget {
  const NewPassScreen({Key? key}) : super(key: key);

  @override
  State<NewPassScreen> createState() => _NewPassScreenState();
}

class _NewPassScreenState extends State<NewPassScreen> {
  final GlobalKey<FormState> newPassKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'reset_password'.tr,
        isBackButtonExist: true,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
        onBackPressed: () {
          // Get.find<AuthController>().updateVerificationCode('');
          Get.back();
        },
      ),
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (controller) {
          return Center(
              child: Stack(
            children: [
              mainUI(context, controller),
              controller.isLoading
                  ? const LoadingIndicator()
                  : const SizedBox(),
            ],
          ));
        }),
      ),
    );
  }

  Form mainUI(BuildContext context, AuthController controller) {
    return Form(
      key: newPassKey,
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 88,
                  ),
                  Text(
                    'create_a_new_password'.tr,
                    style: robotoRegular.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  passwordField(context, controller, 'password'.tr),
                  const SizedBox(
                    height: Dimensions.paddingSizeLarge,
                  ),
                  confirmPasswordField(context, controller, 'new_password'.tr),
                ],
              ),
              CustomButton(
                  onPressed: () => controller.resetPassword(),
                  buttonText: 'save'.tr),
            ]),
      ),
    );
  }

  Column passwordField(BuildContext context, AuthController controller, String hintText) {
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
            controller: controller.currentPasswordControllerForChangePasswordScreen,
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
  }

  Column confirmPasswordField(
      BuildContext context, AuthController controller, String hintText) {
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
            controller: controller.confirmPasswordControllerForChangePasswordScreen,
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
  }
}
