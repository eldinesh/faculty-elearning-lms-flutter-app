import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';

class PhoneSignIn extends StatelessWidget {
  PhoneSignIn({Key? key}) : super(key: key);

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isBackButtonExist: true,
        bgColor: Theme.of(context).cardColor,
        title: 'sign_in_with_phone'.tr,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
        centerTitle: false,
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        return mainUI(context, controller);
      }),
    );
  }

  Column mainUI(BuildContext context, AuthController controller) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Container(
            height: 45,
            width: MediaQuery.of(context).size.width,
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
            child: Row(
              children: [
                SizedBox(
                  width: 120,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CountryPickerDropdown(
                      isFirstDefaultIfInitialValueNotProvided: false,
                      initialValue: "BD",
                      isExpanded: true,
                      itemBuilder: (Country country) => Row(
                        children: <Widget>[
                          CountryPickerUtils.getDefaultFlagImage(country),
                          const SizedBox(width: 2),
                          Text("+${country.phoneCode}"),
                        ],
                      ),
                      onValuePicked: (Country country) {
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: CustomTextField(
                    controller: controller.phoneController,
                    hintText: 'phone_number'.tr,
                    inputType: TextInputType.phone,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: CustomButton(
                onPressed: () {
                  controller.getPhoneLoginOTP();
                },
                buttonText: 'submit'.tr),
          ),
        )
      ],
    );
  }
}
