import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import 'cart_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final Function()? onBackPressed;
  final bool? showCart;
  final bool? centerTitle;
  final Color? bgColor;
  final Color? titleColor;
  final List<Widget>? actions;
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.showCart = false,
      this.centerTitle = false,
      this.bgColor,
      this.titleColor,
      this.actions = const [SizedBox()]});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title!,
        style: robotoMedium.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: titleColor ?? Theme.of(context).primaryColorLight),
      ),
      centerTitle: centerTitle,
      automaticallyImplyLeading: true,
      titleSpacing: isBackButtonExist ? 5 : 10,
      leading: isBackButtonExist
          ? IconButton(
              splashRadius: Dimensions.paddingSizeLarge,
              hoverColor: Colors.transparent,
              icon: Icon(Icons.arrow_back,
                  color: titleColor ?? Theme.of(context).primaryColorLight),
              color: Theme.of(context).textTheme.bodyLarge!.color,
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pop(context),
            )
          : null,
      backgroundColor: bgColor,
      elevation: 0,
      actions: showCart!
          ? [
              IconButton(
                onPressed: () {},
                icon: CartWidget(
                    color: Get.isDarkMode
                        ? Theme.of(context).primaryColorLight
                        : Colors.white,
                    size: Dimensions.cartWidgetSize),
              )
            ]
          : actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(Dimensions.preferredSize);
}
