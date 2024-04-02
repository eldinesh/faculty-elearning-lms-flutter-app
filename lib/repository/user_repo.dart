

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_user_app/data/model/user_info_model.dart';
import 'package:lms_user_app/data/model/user_model/user_data.dart';
import 'package:lms_user_app/data/provider/client_api.dart';
import 'package:lms_user_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  UserRepo({required this.apiClient,required this.sharedPreferences});

  Future<Response?> getUserProfile() {
    return apiClient.getData(AppConstants.profile);
  }

  Future<Response?> editProfile(UserData user, XFile? image) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      'first_name': user.firstName ?? '',
      'last_name': user.lastName ?? '',
      'email': user.email ?? '',
      'phone': user.phone ?? '',
      'gender': user.gender ?? '',
      'address': user.address ?? '',
      'date_of_birth': user.dateOfBirth ?? '2002-01-01'
    });
    return await apiClient.postMultipartData(AppConstants.updateProfile, body,
        image != null ? [MultipartBody('image', image)] : [],null);
  }

  //old
  Future<Response> getUserInfo() async {
    return await apiClient.getData(AppConstants.customerInfoUrl);
  }

  Future<Response> updateProfile(
      UserInfoModel userInfoModel, XFile? data) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      '_method': 'put',
      'first_name': userInfoModel.fName!,
      'last_name': userInfoModel.lName!,
      'email': userInfoModel.email!,
      'phone': userInfoModel.phone!,
    });
    return await apiClient.postMultipartData(AppConstants.updateProfileUrl,
        body, data != null ? [MultipartBody('profile_image', data)] : [], null);
  }

  Future<Response> updateAccountInfo(UserInfoModel userInfoModel) async {
    Map<String, String> body = {};
    body.addAll(<String, String>{
      '_method': 'put',
      'first_name': userInfoModel.fName!,
      'last_name': userInfoModel.lName!,
      'email': userInfoModel.email!,
      'phone': userInfoModel.phone!,
      'password': userInfoModel.password!,
      'confirm_password': userInfoModel.confirmPassword!,
    });
    return await apiClient.putData(AppConstants.updateProfileUrl, body);
  }

  Future<Response> changePassword(UserInfoModel userInfoModel) async {
    return await apiClient.postData(AppConstants.updateProfileUrl, {
      'phone_or_email': userInfoModel.fName,
      'otp': userInfoModel.lName,
      'password': userInfoModel.email,
      'confirm_password': userInfoModel.phone
    });
  }

  Future<Response> deleteUser() async {
    return await apiClient.getData(AppConstants.deleteAccount);
  }
}
