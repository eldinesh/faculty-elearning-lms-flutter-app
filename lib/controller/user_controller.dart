import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lms_user_app/components/custom_snackbar.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/user_model/user_data.dart';
import 'package:lms_user_app/data/model/user_model/user_model.dart';
import 'package:lms_user_app/data/provider/checker_api.dart';
import 'package:lms_user_app/repository/user_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constants.dart';
import 'auth_controller.dart';
import 'cart_controller.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  List genderList = ["Male", "Female"];
  String? selectGender;
  UserModel? userModel;

  File? _selectedImage;
  XFile? _selectedImageFile;
  File? get selectedImageUri => _selectedImage;
  XFile? get selectedImageFile => _selectedImageFile;
  String selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isLoading = false;

  Future<void> getUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstants.token);
    if (token == null) {
      userModel = null;
      isLoading = false;
      update();
      return;
    }
    isLoading = true;
    update();
    final response = await userRepo.getUserProfile();
    if (response != null && response.statusCode == 200) {
      userModel = UserModel.fromJson(response.body);
      firstNameController.text = userModel?.data?.firstName ?? '';
      lastNameController.text =
          userModel?.data?.lastName! == '' ? "" : userModel!.data!.lastName!;
      emailController.text = userModel?.data?.email ?? 'email_address'.tr;
      phoneController.text = userModel?.data?.phone ?? 'phone_number'.tr;
      addressController.text = userModel?.data?.address ?? 'address'.tr;
      selectedDate = userModel?.data?.dateOfBirth ?? '';
      selectGender = genderList[0];
    }
    isLoading = false;
    update();
  }

  void pickImage() async {
    XFile? image;
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      _selectedImageFile = image;
    }
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));
    if (picked != null) {
      final f = DateFormat('yyyy-MM-dd');
      selectedDate = f.format(picked);
    }
    update();
  }

  void changeGenderSelection(String newValue) {
    selectGender = newValue;
    update();
  }

  Future<void> editProfile() async {
    isLoading = true;
    update();
    String firstName = firstNameController.text;
    String lastName = lastNameController.text.isEmpty ? " " : lastNameController.text;
    String email = emailController.text;
    String phone = phoneController.text;
    String gender = selectGender ?? 'Male';
    String address = addressController.text;
    String dob = selectedDate;
    XFile? image = selectedImageFile;
    UserData user = UserData(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        gender: gender,
        dateOfBirth: dob,
        address: address);
    final response = await userRepo.editProfile(user, image);
    print(selectGender);

    if (response != null && response.statusCode == 200) {
      await getUserProfile();
      customSnackBar("${response.body['message']}".tr, isError: false);
    } else {
      String? errorMessage = 'something_wrong'.tr;
      if (response?.body['data']['first_name'] != null) {
        errorMessage = response?.body['data']['first_name'][0].toString();
      } else if (response?.body['data']['last_name'] != null) {
        errorMessage = response?.body['data']['last_name'][0].toString();
      } else if (response?.body['data']['email'] != null) {
        errorMessage = response?.body['data']['email'][0].toString();
      } else if (response?.body['data']['phone'] != null) {
        errorMessage = response?.body['data']['phone'][0].toString();
      } else if (response?.body['data']['gender'] != null) {
        errorMessage = response?.body['data']['gender'][0].toString();
      } else if (response?.body['data']['address'] != null) {
        errorMessage = response?.body['data']['address'][0].toString();
      } else if (response?.body['data']['date_of_birth'] != null) {
        errorMessage = response?.body['data']['date_of_birth'][0].toString();
      } else {
        errorMessage = 'something_wrong'.tr;
      }
      customSnackBar(errorMessage);
    }
    isLoading = false;
    update();
  }

//old
  Future removeUser() async {
    update();
    Response response = await userRepo.deleteUser();
    if (response.statusCode == 200) {
      customSnackBar('your_account_remove_successfully'.tr);
      Get.find<AuthController>().clearSharedData();
      Get.find<CartController>().clearCartList();
      Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.profile));
    } else {
      Get.back();
      ApiChecker.checkApi(response);
    }
  }
}
