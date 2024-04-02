import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'dart:io' show Platform;
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../components/loading_indicator.dart';

class SignInScreen extends StatelessWidget {
  final String fromPage;
  const SignInScreen({Key? key, required this.fromPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackButtonExist: fromPage == "fromSplash" || fromPage == "onboard" ? false : true,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return Container(
            color: Theme.of(context).cardColor,
            child: Stack(
              children: [
                mainUI(context, controller),
                controller.isLoading
                    ? const LoadingIndicator()
                    : const SizedBox(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget mainUI(BuildContext context, AuthController controller) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 100,
              child: SvgPicture.asset(
                Images.splash,
                // scale: 3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'sign_in'.tr,
              style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeOverLarge,
                  color: Theme.of(context).textTheme.bodyLarge!.color!),
            ),
            const SizedBox(height: 60),
            emailField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            passwordField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            CustomButton(
                onPressed: () => controller.login(), buttonText: 'sign_in'.tr),
            const SizedBox(
              height: 30,
            ),
            newUserUI(context),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            continueButton(context),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                        onTap: () => controller.socialLogin(),
                        child: SvgPicture.asset(Images.googleAuth))),
                const SizedBox(width: Dimensions.paddingSizeLarge),
                ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: GestureDetector(
                        onTap: () => controller.facebookAuth(),
                        child: SvgPicture.asset(Images.facebookAuth))),
                const SizedBox(width: Dimensions.paddingSizeLarge),
                if (Platform.isIOS)
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GestureDetector(
                          onTap: () => controller.appleAuth(),
                          child: SvgPicture.asset(Images.appleAuth))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell continueButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.main);
      },
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
        child: Text('or_continue_with'.tr,
            style: robotoRegular.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.5),
                fontSize: Dimensions.fontSizeSmall)),
      ),
    );
  }

  Row newUserUI(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('new_user'.tr,
            style: robotoRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
                fontSize: Dimensions.fontSizeSmall)),
        InkWell(
          onTap: () {
            Get.toNamed(RouteHelper.signUp);
          },
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Text('create_account'.tr,
                style: robotoRegular.copyWith(
                    color: Get.isDarkMode
                        ? Colors.green
                        : Theme.of(context).primaryColor,
                    fontSize: Dimensions.fontSizeSmall)),
          ),
        ),
      ],
    );
  }

  Widget emailField(BuildContext context, AuthController controller) {
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
                  .withOpacity(0.06),
            ),
            borderRadius: const BorderRadius.all(
                Radius.circular(Dimensions.paddingSizeExtraSmall)),
          ),
          child: CustomTextField(
            hintText: 'email_address'.tr,
            controller: controller.signInEmailController,
            inputType: TextInputType.emailAddress,
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
                  Images.mail,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
      ],
    );
  }

  Column passwordField(BuildContext context, AuthController controller) {
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
            hintText: 'password'.tr,
            controller: controller.signInPasswordController,
            inputType: TextInputType.visiblePassword,
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
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        InkWell(
          onTap: () => Get.toNamed(RouteHelper.forgotPasswordScreen),
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Text(
              'forget_password'.tr,
              style: robotoRegular.copyWith(
                  color: Get.isDarkMode
                      ? Colors.green
                      : Theme.of(context).primaryColor,
                  fontSize: Dimensions.fontSizeSmall),
            ),
          ),
        ),
      ],
    );
  }
}
