import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/controller/user_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../components/loading_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Edit Profile",
        isBackButtonExist: true,
        bgColor: Theme.of(context).cardColor,
        titleColor: Theme.of(context).textTheme.bodyLarge!.color,
      ),
      body: GetBuilder<UserController>(
        initState: (state) => Get.find<UserController>().getUserProfile(),
        builder: (controller) {
          return Container(
            color: Theme.of(context).cardColor,
            child: Stack(
              children: [
                controller.userModel == null
                    ? const LoadingIndicator()
                    : mainUI(context, controller),
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

  Widget mainUI(BuildContext context, UserController controller) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Stack(
                children: [
                  if (controller.userModel != null &&
                      controller.selectedImageUri == null)
                    Padding(
                      padding: const EdgeInsets.all(1), // Border radius
                      child: ClipOval(
                          child: Image.network(
                            controller.userModel?.data?.image ?? '',
                            fit: BoxFit.cover,
                            height: 75,
                            width: 75,
                            errorBuilder: (context, error, stackTrace) =>
                            Image.asset(Images.placeholder),
                      )),
                    ),
                  if (controller.selectedImageUri != null)
                    Padding(
                      padding: const EdgeInsets.all(1), // Border radius
                      child: ClipOval(
                        child: controller.selectedImageUri != null
                            ? Image.file(
                                controller.selectedImageUri!,
                                fit: BoxFit.cover,
                                height: 75,
                                width: 75,
                              )
                            : Image.asset(
                                Images.demoProfile,
                                fit: BoxFit.cover,
                                height: 75,
                                width: 75,
                              ),
                      ),
                    ),
                  Positioned(
                    bottom: 4,
                    right: 5,
                    child: InkWell(
                      onTap: () => controller.pickImage(),
                      child: Container(
                        height: 18,
                        width: 18,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                          //color: Colors.white,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).cardColor,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            firstNameField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            lastNameField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            emailAddressField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            phoneNumberField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            genderField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            dateOfBirthField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeDefault),
            addressField(context, controller),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            controller.isLoading == true
                ? const SizedBox()
                : CustomButton(
                    onPressed: () => controller.editProfile(),
                    buttonText: 'update_profile'.tr),
            const SizedBox(height: Dimensions.paddingSizeExtraLarge),
          ],
        ),
      ),
    );
  }

  Column firstNameField(BuildContext context, UserController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'first_name'.tr,
          style: robotoMedium.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: Dimensions.fontSizeDefault),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Container(
          height: 44,
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
          ),
        ),
      ],
    );
  }
}

Column lastNameField(BuildContext context, UserController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'last_name'.tr,
        style: robotoMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: Dimensions.fontSizeDefault),
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.paddingSizeExtraSmall),
          ),
        ),
        child: CustomTextField(
          hintText: 'last_name'.tr,
          controller: controller.lastNameController,
        ),
      ),
    ],
  );
}

Column emailAddressField(BuildContext context, UserController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'email_address'.tr,
        style: robotoMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: Dimensions.fontSizeDefault),
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.paddingSizeExtraSmall)),
        ),
        child: CustomTextField(
          hintText: 'email_address'.tr,
          controller: controller.emailController,
        ),
      ),
    ],
  );
}

Column phoneNumberField(BuildContext context, UserController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'phone'.tr,
        style: robotoMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: Dimensions.fontSizeDefault),
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.paddingSizeExtraSmall)),
        ),
        child: CustomTextField(
          hintText: 'phone'.tr,
          controller: controller.phoneController,
        ),
      ),
    ],
  );
}

Column genderField(BuildContext context, UserController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'gender'.tr,
        style: robotoMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: Dimensions.fontSizeDefault),
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Container(
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.paddingSizeExtraSmall),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 5, top: 3, bottom: 3),
          child: DropdownButton<String>(
            hint: Text('select_gender'.tr),
            value: controller.selectGender,
            isExpanded: true,
            underline: Container(),
            onChanged: (String? newValue) {
              controller.changeGenderSelection(newValue!);
            },
            items: controller.genderList.map((user) {
              return DropdownMenuItem<String>(
                value: user,
                child: Text(
                  user,
                  style: robotoRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.6)),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ],
  );
}

Widget dateOfBirthField(BuildContext context, UserController controller) {
  return InkWell(
    onTap: () => controller.selectDate(context),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth'.tr,
          style: robotoMedium.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: Dimensions.fontSizeDefault),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        Container(
          height: 44,
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
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.selectedDate,
                  style: robotoRegular.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.6)),
                ),
                SvgPicture.asset(Images.calendar),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Column addressField(BuildContext context, UserController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'address'.tr,
        style: robotoMedium.copyWith(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: Dimensions.fontSizeDefault),
      ),
      const SizedBox(height: Dimensions.paddingSizeDefault),
      Container(
        //height: 44,
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.06),
          ),
          borderRadius: const BorderRadius.all(
              Radius.circular(Dimensions.paddingSizeExtraSmall)),
        ),
        child: CustomTextField(
          hintText: 'address'.tr,
          controller: controller.addressController,
          maxLines: 3,
        ),
      ),
    ],
  );
}
