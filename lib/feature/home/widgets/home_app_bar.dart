import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/controller/cart_controller.dart';
import 'package:lms_user_app/controller/user_controller.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../controller/auth_controller.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;

  const HomeAppBar({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leadingWidth: backButton! ? Dimensions.paddingSizeLarge : 0,
      leading: backButton!
          ? Padding(
              padding:
                  const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Theme.of(context).cardColor,
                onPressed: () => Navigator.pop(context),
              ),
            )
          : const SizedBox(),
      title: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: Dimensions.paddingSizeDefault),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //user profile
              GetBuilder<UserController>(
                  initState: (state) =>
                      Get.find<UserController>().getUserProfile(),
                  builder: (controller) {
                    return Expanded(
                      child: controller.userModel == null
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                height: Get.statusBarHeight,
                                width: Get.statusBarHeight * 2,
                                child: SvgPicture.asset(
                                  Images.splash,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                Get.toNamed(RouteHelper.profile);
                              },
                              borderRadius: BorderRadius.circular(30),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                            Dimensions.radiusExtraLarge)),
                                    child: CustomImage(
                                        height: 40,
                                        width: 40,
                                        image:
                                            controller.userModel?.data?.image ??
                                                ''),
                                  ),
                                  const SizedBox(
                                    width: Dimensions.paddingSizeSmall,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.userModel?.data?.name ?? '',
                                        style: robotoBold.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontWeight: FontWeight.w600,
                                            fontSize:
                                                Dimensions.fontSizeDefault),
                                      ),
                                      Text(
                                        controller.userModel?.data?.email ?? '',
                                        style: robotoRegular.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize: Dimensions.fontSizeSmall),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                    );
                  }),
              Row(
                children: [
                  if (Get.find<AuthController>().isLoggedIn())
                    GetBuilder<CartController>(
                        builder: (controller) {
                      return InkWell(
                        hoverColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        onTap: () => Get.toNamed(RouteHelper.getCartScreen()),
                        child: Padding(
                          padding: const EdgeInsets.all(Dimensions.paddingSizeRadius),
                          child:controller.cartList.isNotEmpty ?  badges.Badge(
                            badgeContent: Text("${controller.cartList.length}",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Colors.white)),
                            badgeStyle: const badges.BadgeStyle(
                                badgeColor: Colors.black),
                            child: SvgPicture.asset(Images.cartSvg),
                          ):const SizedBox(),
                        ),
                      );
                    }),
                  InkWell(
                    hoverColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Get.toNamed(RouteHelper.notificationScreen);
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeRadius),
                      child: SvgPicture.asset(
                        Images.notification,
                      ),
                    ),
                  ),
                  InkWell(
                    hoverColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () => Get.toNamed(RouteHelper.searchScreen),
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeRadius),
                      child: SvgPicture.asset(
                        Images.search,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
