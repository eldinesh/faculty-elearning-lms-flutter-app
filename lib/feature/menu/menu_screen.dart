import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/auth_controller.dart';
import 'package:lms_user_app/core/helper/responsive_helper.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/menu_model.dart';
import 'package:lms_user_app/feature/menu/menu_button.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    double ratio = ResponsiveHelper.isTab(context) ? 1.1 : 1.2;
    final List<MenuModel> menuList = [
      if (Get.find<AuthController>().isLoggedIn())
        MenuModel(
            icon: Images.menuProfile,
            title: 'profile'.tr,
            route: RouteHelper.getProfileRoute()),
      // // MenuModel(icon: Images.bookStore, title: 'book_store'.tr, route: RouteHelper.getBookStoreScreen()),
      // MenuModel(
      //     icon: Images.settingsMenu,
      //     title: 'settings'.tr,
      //     route: RouteHelper.settingScreen),
      MenuModel(
          icon: Images.languageMenu,
          title: 'language'.tr,
          route: RouteHelper.language),
      MenuModel(
          icon: Images.about,
          title: 'about'.tr,
          route: RouteHelper.getHtmlRoute('about_us')),
      MenuModel(
          icon: Images.termsAndConditions,
          title: 'terms_and_conditions'.tr,
          route: RouteHelper.getHtmlRoute('terms_and_conditions')),
      MenuModel(
          icon: Images.privacyPolicy,
          title: 'privacy_policy'.tr,
          route: RouteHelper.getHtmlRoute('privacy_policy')),
      MenuModel(
          icon: Images.helpAndSupport,
          title: 'help_and_support'.tr,
          route: RouteHelper.getHtmlRoute('help_and_support')),
      MenuModel(
          icon: Images.darkMode,
          title: Get.isDarkMode ? 'light_mode'.tr : 'dark_mode'.tr,
          route: "dark_mode"),
      MenuModel(
          icon: isLoggedIn ? Images.logout : Images.menuProfile,
          title: isLoggedIn ? 'logout'.tr : 'sign_in'.tr,
          route: ''),
    ];

    return Container(
      width: width,
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        color: Theme.of(context).cardColor,
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
          onTap: () => Get.back(),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: ResponsiveHelper.isTab(context) ? 6 : 4,
            childAspectRatio: (1 / ratio),
            crossAxisSpacing: Dimensions.paddingSizeExtraSmall,
            mainAxisSpacing: Dimensions.paddingSizeExtraSmall,
          ),
          itemCount: menuList.length,
          itemBuilder: (context, index) {
            return MenuButton(
                menu: menuList[index], isLogout: index == menuList.length - 1);
          },
        ),
        SizedBox(
            height: ResponsiveHelper.isMobile(context)
                ? Dimensions.paddingSizeSmall
                : 0),
      ]),
    );
  }
}
