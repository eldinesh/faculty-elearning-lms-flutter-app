import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../components/loading_indicator.dart';

class PhoneSignUpScreen extends StatelessWidget {
  const PhoneSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackButtonExist: true,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return Stack(
          children: [
            mainUI(context, controller),
            controller.isLoading ? const LoadingIndicator() : const SizedBox(),
          ],
        );
      }),
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
            const SizedBox(
              height: 46,
            ),
            Text(
              'sign_up'.tr,
              style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeOverLarge,
                  color: Theme.of(context).textTheme.bodyLarge!.color!),
            ),
            const SizedBox(height: 60),
            firstNameField(context, controller),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            lastNameField(context, controller),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            phoneField(context, controller),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            CustomButton(
                onPressed: () => controller.registrationWithPhoneNumber(),
                buttonText: 'sign_up'.tr),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('already_have_an_account'.tr,
                    style: robotoRegular.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge!.color!,
                        fontSize: Dimensions.fontSizeSmall)),
                InkWell(
                  onTap: () {
                    Get.offNamed(
                        RouteHelper.getSignInRoute(RouteHelper.signUp));
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                    child: Text('sign_in_here'.tr,
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeSmall)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
            InkWell(
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
            ),
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
                SvgPicture.asset(Images.facebookAuth),
                const SizedBox(width: Dimensions.paddingSizeLarge),
                SvgPicture.asset(Images.appleAuth),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column confirmPasswordField(BuildContext context, AuthController controller) {
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
            hintText: 'confirm_password'.tr,
            controller: controller.confirmPasswordController,
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
            controller: controller.passwordController,
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

  Column phoneField(BuildContext context, AuthController controller) {
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
            hintText: 'phone_number'.tr,
            controller: controller.phoneController,
            inputType: TextInputType.phone,
            inputAction: TextInputAction.next,
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
                  Images.phone,
                  color: const Color(0xff999999),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column firstNameField(BuildContext context, AuthController controller) {
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
            hintText: 'first_name'.tr,
            controller: controller.firstNameController,
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
                  Images.user,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Column lastNameField(BuildContext context, AuthController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.paddingSizeExtraSmall)),
        ),
        child: CustomTextField(
          hintText: 'last_name'.tr,
          controller: controller.lastNameController,
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
                Images.user,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
