import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/config.dart';
import 'package:lms_user_app/data/model/assignment_model/assignment_model.dart';
import 'package:lms_user_app/feature/allCourse/all_course_screen.dart';
import 'package:lms_user_app/feature/assignment/assignment_details_screen.dart';
import 'package:lms_user_app/feature/assignment/assignment_screen.dart';
import 'package:lms_user_app/feature/auth/change_password/change_password_screen.dart';
import 'package:lms_user_app/feature/auth/email_verification_screen.dart';
import 'package:lms_user_app/feature/auth/forgot_password/forgot_password_screen.dart';
import 'package:lms_user_app/feature/bookDetails/book_details_screen.dart';
import 'package:lms_user_app/feature/bookStore/book_store_screen.dart';
import 'package:lms_user_app/controller/splash_controller.dart';
import 'package:lms_user_app/core/initial_binding/initial_binding.dart';
import 'package:lms_user_app/feature/auth/forgot_password/new_pass_screen.dart';
import 'package:lms_user_app/feature/auth/phoneSignIn/phone_sign_in.dart';
import 'package:lms_user_app/feature/auth/phone_signup_screen.dart';
import 'package:lms_user_app/feature/auth/sign_in_screen.dart';
import 'package:lms_user_app/feature/auth/sign_up_screen.dart';
import 'package:lms_user_app/feature/auth/phoneSignIn/verification_screen.dart';
import 'package:lms_user_app/feature/cart/cart_screen.dart';
import 'package:lms_user_app/feature/cheekOut/payment_screen.dart';
import 'package:lms_user_app/feature/classRoom/learning_screen.dart';
import 'package:lms_user_app/feature/contact_us_page.dart';
import 'package:lms_user_app/feature/conversation/view/conversation_list.dart';
import 'package:lms_user_app/feature/coupon/coupon_screen.dart';
import 'package:lms_user_app/feature/courseCategory/course_category.dart';
import 'package:lms_user_app/feature/courseDetails/course_details_screen.dart';
import 'package:lms_user_app/feature/html/html_viewer_screen.dart';
import 'package:lms_user_app/feature/invoice/invoice_screen.dart';
import 'package:lms_user_app/feature/landing/landing_screen.dart';
import 'package:lms_user_app/feature/meeting/meeting_screen.dart';
import 'package:lms_user_app/feature/not_logged_in_screen.dart';
import 'package:lms_user_app/feature/cheekOut/cheek_out_screen.dart';
import 'package:lms_user_app/feature/notification/notification_screen.dart';
import 'package:lms_user_app/feature/onboarding/view/onboarding_screen.dart';
import 'package:lms_user_app/feature/order/order_history_screen.dart';
import 'package:lms_user_app/feature/organization/organization_screen.dart';
import 'package:lms_user_app/feature/profile/edit_profile_screen.dart';
import 'package:lms_user_app/feature/profile/profile_screen.dart';
import 'package:lms_user_app/feature/profile/widgets/certificate_screen.dart';
import 'package:lms_user_app/feature/quiz/quiz_detail_page.dart';
import 'package:lms_user_app/feature/quiz/quiz_result_screen.dart';
import 'package:lms_user_app/feature/quiz/quiz_start_page.dart';
import 'package:lms_user_app/feature/resources/resource_screen.dart';
import 'package:lms_user_app/feature/root/view/not_found_screen.dart';
import 'package:lms_user_app/feature/root/view/update_screen.dart';
import 'package:lms_user_app/feature/searchScreen/search_screen.dart';
import 'package:lms_user_app/feature/settings/settings_screen.dart';
import 'package:lms_user_app/feature/splash_screen.dart';
import 'package:lms_user_app/utils/html_type.dart';
import 'package:lms_user_app/utils/language_change.dart';
import '../../feature/auth/forgot_password/otp_verification_screen.dart';
import '../../feature/conversation/view/conversation_screen.dart';
import '../../feature/instructorDetails/instructor_detail_screen.dart';
import '../../feature/searchScreen/widget/search_result_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String language = '/language';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String main = '/main';
  static const String home = '/home';
  static const String searchScreen = '/searchScreen';
  static const String searchResultScreen = '/searchResultScreen';
  static const String service = '/service';
  static const String profile = '/profile';
  static const String profileEdit = '/profile-edit';
  static const String address = '/address';
  static const String html = '/html';
  static const String categories = '/categories';
  static const String support = '/help-and-support';
  static const String rateReview = '/rate-and-review';
  static const String cart = '/cart';
  static const String update = '/update';
  static const String settingScreen = '/settingScreen';
  static const String notLoggedScreen = '/notLoggedScreen';
  static const String courseDetailsScreen = '/courseDetailsScreen';
  static const String instructorDetails = '/instructorDetails';
  static const String cheekOutScreen = '/cheekOutScreen';
  static const String phoneSignIn = '/phoneSignIn';
  static const String phoneSignUpScreen = '/phone_sign_up_screen';
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String bookStoreScreen = '/bookStoreScreen';
  static const String organizationScreen = '/organizationScreen';
  static const String conversationScreen = '/conversationScreen';
  static const String couponScreen = '/couponScreen';
  static const String orderHistoryScreen = '/orderHistoryScreen';
  static const String verificationScreen = '/verificationScreen';
  static const String bookDetailsScreen = '/bookDetailsScreen';
  static const String invoiceScreen = '/invoiceScreen';
  static const String emailVerificationScreen = '/emailVerificationScreen';
  //forgot password
  static const String forgotPasswordScreen = '/forgot_password_screen';
  static const String forgotPasswordOTPVerificationScreen =
      '/forgot_password_otp_verification_screen';
  static const String newPasswordScreen = '/new_password_screen';
  static const String meetingScreen = '/meetingScreen';
  static const String myAssignmentScreen = '/myAssignmentScreen';
  static const String certificateScreen = '/certificateScreen';
  static const String editProfileScreen = '/editProfileScreen';
  static const String conversationList = '/conversationList';
  static const String quizStartPage = '/quizStartPage';
  static const String learningScreen = '/learningScreen';
  static const String quizDetailsScreen = '/QuizDetailScreen';
  static const String quizResultScreen = '/QuizResultScreen';
  static const String languageChange = '/languageChange';
  static const String videoPlayerScreen = '/videoPlayerScreen';
  static const String categoryScreen = '/categoryScreen';
  static const String allCourseScreen = '/allCourseScreen';
  static const String paymentScreen = '/paymentScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String changePassword = '/changePasswordScreen';
  static const String assignmentDetailsScreen = '/assignmentDetailsScreen';
  static const String resourceScreen = '/resourceScreen';

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getLanguageRoute(String page) => '$language?page=$page';
  static String getSignInRoute(String page) => '$signIn?page=$page';
  static String getMainRoute(String page) => '$main?page=$page';
  static String getSearchResultRoute({String? queryText}) =>
      '$searchScreen?query=${queryText ?? ''}';

  static String getServiceRoute(String id) => '$service?id=$id';
  static String getProfileRoute() => profile;
  static String getEditProfileRoute() => profileEdit;
  static String getHtmlRoute(String page) => '$html?page=$page';
  static String getSupportRoute() => support;
  static String getReviewRoute() => rateReview;
  static String getCourseDetailsScreenRoute() => courseDetailsScreen;
  static String getInstructorDetails() => instructorDetails;
  static String getCartScreen() => cart;
  static String getCheekOutScreen() => cheekOutScreen;
  static String getPhoneSignIn() => phoneSignIn;
  static String getPhoneSignUpScreen() => phoneSignUpScreen;
  static String getOnBoardingScreen() => onBoardingScreen;
  static String getBookStoreScreen() => bookStoreScreen;
  static String getOrganizationScreen() => organizationScreen;
  static String getConversationScreen() => conversationScreen;
  static String getCouponScreen() => couponScreen;
  static String getOrderHistoryScreen() => orderHistoryScreen;
  static String getVerificationScreen() => verificationScreen;
  static String getBookDetailsScreen() => bookDetailsScreen;
  static String getInvoiceScreen() => invoiceScreen;
  static String getMeetingScreen() => meetingScreen;
  static String getMyAssignmentScreen() => myAssignmentScreen;
  static String getCertificateScreen() => certificateScreen;
  static String getEditProfileScreen() => editProfileScreen;
  static String getConversationList() => conversationList;
  static String getQuizStartPage() => quizStartPage;
  static String getLearningScreen(String courseID, String courseTitle) => '$learningScreen?courseID=$courseID&courseTitle=$courseTitle';
  static String getLanguageChange() => languageChange;
  static String getVideoPlayerScreen() => videoPlayerScreen;
  static String getCategoryScreen() => categoryScreen;
  static String getPaymentScreen() => paymentScreen;
  static String getAssignmentDetailsScreen(Assignments assignments) {
    List<int> encoded = utf8.encode(jsonEncode(assignments.toJson()));
    String data = base64Encode(encoded);
    return '$assignmentDetailsScreen?assignmentModel=$data';
  }
  static String getAllCourseScreen(String categoryID, String title) => '$allCourseScreen?categoryID=$categoryID&title=$title';
  static String getResourceScreen(String courseID) => '$resourceScreen?courseID=$courseID';

  static List<GetPage> routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(
        name: signIn,
        page: () => SignInScreen(
            fromPage: Get.parameters['page']!
        )),
    GetPage(name: signUp, page: () => const SignUpScreen()),
    GetPage(name: main, page: () => const MainScreen(pageIndex: 0)),
    GetPage(
        name: emailVerificationScreen,
        page: () => const EmailVerificationScreen()),
    //forgot password
    GetPage(
        name: forgotPasswordScreen, page: () => const ForgotPasswordScreen()),
    GetPage(
        name: forgotPasswordOTPVerificationScreen,
        page: () => const ForgotPasswordOTPVerificationScreen()),
    GetPage(name: newPasswordScreen, page: () => const NewPassScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),

    GetPage(
        binding: InitialBinding(),
        name: html,
        page: () => HtmlViewerScreen(
            htmlType: Get.parameters['page'] == 'terms_and_conditions'
                ? HtmlType.termsAndConditions
                : Get.parameters['page'] == 'privacy_policy'
                    ? HtmlType.privacyPolicy
                    : Get.parameters['page'] == 'help_and_support'
                        ? HtmlType.helpAndSupport
                        : Get.parameters['page'] == 'about_us'
                            ? HtmlType.aboutUs
                            : HtmlType.aboutUs)),
    GetPage(name: support, page: () => getRoute(const ContactUsPage())),
    GetPage(
        name: update,
        page: () => UpdateScreen(isUpdate: Get.parameters['update'] == 'true')),
    GetPage(name: cart, page: () => const CartScreen()),
    GetPage(name: cheekOutScreen, page: () => const CheekOutScreen()),
    GetPage(
        name: rateReview,
        page: () => getRoute(Get.arguments ?? const NotFoundScreen())),
    GetPage(name: settingScreen, page: () => const SettingScreen()),
    GetPage(
        name: notLoggedScreen,
        page: () => NotLoggedInScreen(fromPage: Get.parameters['fromPage']!)),
    GetPage(name: courseDetailsScreen, page: () => const CourseDetailsScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(
        name: searchResultScreen,
        page: () => SearchResultScreen(queryText: Get.parameters['query'])),
    GetPage(name: searchScreen, page: () => const SearchScreen()),
    GetPage(
        name: instructorDetails, page: () => const InstructorDetailScreen()),
    GetPage(name: phoneSignIn, page: () => PhoneSignIn()),
    GetPage(name: phoneSignUpScreen, page: () => const PhoneSignUpScreen()),
    GetPage(name: onBoardingScreen, page: () => const OnBoardingScreen()),
    GetPage(name: bookStoreScreen, page: () => const BookStoreScreen()),
    GetPage(name: organizationScreen, page: () => const OrganizationScreen()),
    GetPage(name: conversationScreen, page: () => const ConversationScreen()),
    //GetPage(name: conversationScreen, page: () =>  ConversationScreen()),
    GetPage(name: couponScreen, page: () => const CouponScreen()),
    GetPage(name: orderHistoryScreen, page: () => const OrderHistoryScreen()),
    GetPage(name: verificationScreen, page: () => const VerificationScreen()),
    GetPage(name: bookDetailsScreen, page: () => const BookDetailsScreen()),
    GetPage(name: invoiceScreen, page: () => const InvoiceScreen()),
    GetPage(name: meetingScreen, page: () => const MeetingScreen()),
    GetPage(name: myAssignmentScreen, page: () => const MyAssignmentScreen()),
    GetPage(name: certificateScreen, page: () => const CertificateScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: conversationList, page: () => const ConversationList()),
    GetPage(name: quizStartPage, page: () => const QuizStartPage()),

    GetPage(
        name: learningScreen,
        page: () => LearningScreen(
          courseID: Get.parameters['courseID']!,
          courseTitle: Get.parameters['courseTitle']!,
        )
    ),

    GetPage(name: quizDetailsScreen, page: () => const QuizDetailScreen()),
    GetPage(name: quizResultScreen, page: () => const QuizResultScreen()),
    GetPage(name: notificationScreen, page: () => const NotificationScreen()),
    GetPage(name: languageChange, page: () => const LanguageChange()),
    GetPage(name: videoPlayerScreen, page: () => const LanguageChange()),
    GetPage(name: categoryScreen, page: () => const CourseCategoryScreen()),
    GetPage(
        name: allCourseScreen,
        page: () => AllCourseScreen(
              title: Get.parameters['title'],
              categoryID: Get.parameters['categoryID'],
            )),
    GetPage(name: paymentScreen, page: () => const PaymentScreen()),
    GetPage(
        name: assignmentDetailsScreen,
        page: () {
          List<int> decode = base64Decode(Get.parameters['assignmentModel']!.replaceAll(' ', '+'));
          Assignments data = Assignments.fromJson(jsonDecode(utf8.decode(decode)));
          return  AssignmentDetailsScreen(assignments: data);
        }
    ),
    GetPage(
        name: resourceScreen,
        page: () => ResourceScreen(
          courseID: Get.parameters['courseID']!,
        )),
  ];

  static getRoute(Widget navigateTo) {
    double minimumVersion = 1;
    if (Get.find<SplashController>().configModel.data != null) {
      if (GetPlatform.isAndroid) {
        minimumVersion = double.parse(Get.find<SplashController>()
            .configModel
            .data!
            .androidVersion
            .latestApkVersion);
      } else if (GetPlatform.isIOS) {
        minimumVersion = double.parse(Get.find<SplashController>()
            .configModel
            .data!
            .iosVersion
            .latestIpaVersion);
      }
    }
    return Config.appVersion < minimumVersion
        ? const UpdateScreen(isUpdate: true)
        : navigateTo;
  }
}
