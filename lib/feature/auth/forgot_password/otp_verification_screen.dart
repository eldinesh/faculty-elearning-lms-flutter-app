import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordOTPVerificationScreen extends StatefulWidget {
  const ForgotPasswordOTPVerificationScreen({super.key});

  @override
  State<ForgotPasswordOTPVerificationScreen> createState() =>
      _ForgotPasswordOTPVerificationScreenState();
}

class _ForgotPasswordOTPVerificationScreenState
    extends State<ForgotPasswordOTPVerificationScreen> {
  String? _email;

  @override
  void initState() {
    super.initState();
    _email = Get.arguments;
    Get.find<AuthController>().verificationCode == "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        bgColor: Theme.of(context).cardColor,
        title: 'otp_verification'.tr,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
        centerTitle: false,
      ),
      body: GetBuilder<AuthController>(builder: (authController) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              mainUI(context, authController),
              authController.isLoading
                  ? const LoadingIndicator()
                  : const SizedBox(),
            ],
          ),
        );
      }),
    );
  }

  Column mainUI(BuildContext context, AuthController authController) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'enter_the_verification_code'.tr,
                style: robotoRegular.copyWith(
                    height: 1.5,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(.6),
                    fontSize: Dimensions.fontSizeSmall),
                children: [
                  const TextSpan(
                    text: "  ",
                  ),
                  TextSpan(
                      //text: _number!.substring(1, _number!.length - 1),
                      text: _email,
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(.6),
                          fontSize: Dimensions.fontSizeSmall)),
                ],
              ),
            ),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: PinCodeTextField(
                  length: 4,
                  appContext: context,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.slide,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 46,
                    fieldWidth: 46,
                    borderWidth: 1,
                    borderRadius:
                        BorderRadius.circular(Dimensions.paddingSizeSmall),
                    selectedColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    selectedFillColor: Theme.of(context).primaryColorLight,
                    inactiveFillColor: Theme.of(context).cardColor,
                    inactiveColor: Theme.of(context).primaryColorLight,
                    activeColor:
                        Theme.of(context).primaryColor.withOpacity(0.2),
                    activeFillColor: Theme.of(context).cardColor,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onChanged: authController.updateVerificationCode,
                  beforeTextPaste: (text) => true,
                ),
              ),
            ),
          ],
        ),

        Column(
          children: [
            authController.verificationCode.length == 4
                ? !authController.isLoading
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: Dimensions.paddingSizeExtraLarge,
                        ),
                        child: CustomButton(
                          buttonText: 'submit'.tr,
                          onPressed: () {
                            if (isRedundentClick(DateTime.now())) {
                              return;
                            }
                            authController.verifyOTPForForgotPassword(_email!);
                          },
                        ),
                      )
                    : const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink(),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
          ],
        ),
      ],
    );
  }
}
