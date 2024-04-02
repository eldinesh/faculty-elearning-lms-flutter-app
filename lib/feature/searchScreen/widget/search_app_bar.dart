import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/feature/searchScreen/widget/search_widget.dart';
import 'package:lms_user_app/utils/dimensions.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  const SearchAppBar({super.key, this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: Dimensions.paddingSizeExtraLarge,),
          Row(
            children: [
              backButton! ? Padding(
                padding: const EdgeInsets.only(left: Dimensions.paddingSizeExtraLarge),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios,),
                  color: Theme.of(context).primaryColorLight,
                  onPressed: () => Navigator.pop(context),
                ),
              ) : const SizedBox(),
              const Expanded(child: SearchWidget()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(Get.width, 70 );

}