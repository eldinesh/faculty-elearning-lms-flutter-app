import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../components/custom_app_bar.dart';
import '../../components/custom_button.dart';
import '../../components/loading_indicator.dart';
import '../../controller/auth_controller.dart';
import '../../core/helper/help_me.dart';
import '../../utils/dimensions.dart';
import '../../utils/styles.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  String? _email;
  Timer? _timer;
  int? _seconds = 0;

  @override
  void initState() {
    super.initState();
    _email = Get.arguments;
    Get.find<AuthController>().verificationCode == "";
    _startTimer();
  }

  void _startTimer() {
    _seconds = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _seconds = _seconds! - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        bgColor: Theme.of(context).cardColor,
        title: 'email_otp_verification'.tr,
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
                            authController.verifyEmailOTP(_email!);
                          },
                        ),
                      )
                    : const SizedBox()
                : const SizedBox.shrink(),
            const SizedBox(
              height: Dimensions.paddingSizeExtraLarge,
            ),
            SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'did_not_receive_the_code'.tr,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(.6)),
                  ),
                  _seconds == 0
                      ? TextButton(
                          onPressed: () {
                            authController.resendEmailOTP(_email!).then(
                                (value) =>
                                    value == true ? _startTimer() : null);
                          },
                          child: Text(
                            'resend_it'.tr,
                            style: robotoMedium.copyWith(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(.6)),
                            textAlign: TextAlign.end,
                          ),
                        )
                      : Text(
                          _seconds.toString(),
                          style: robotoMedium.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(.6)),
                          textAlign: TextAlign.end,
                        ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
