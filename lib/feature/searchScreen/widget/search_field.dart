import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:lms_user_app/controller/search_controller.dart' as lms_search;

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<lms_search.SearchController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.radiusLarge),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimensions.paddingSizeExtraSmall),
              child: IconButton(
                  onPressed: () {
                    controller.clearSearchController();
                    controller.removeService();
                    Get.back();
                  },
                  splashRadius: Dimensions.paddingSizeExtraLarge,
                  icon: const Icon(Icons.arrow_back)),
            ),
            Expanded(
              child: Container(
                height: 42,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.04),
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(Dimensions.paddingSizeExtraSmall),
                  ),
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (value) =>
                      controller.showSuffixIcon(context, value),
                  onSubmitted: (value) =>
                      controller.searchData(value, shouldUpdate: true),
                  cursorHeight: 16,
                  cursorWidth: 2,
                  cursorColor: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                  style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall),
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          const BorderSide(style: BorderStyle.none, width: 0),
                    ),
                    contentPadding:
                        const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    hintText: 'search_item'.tr,
                    hintStyle: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeSmall),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(Dimensions.radiusDefault),
                      child: SvgPicture.asset(
                        Images.search,
                        height: 14,
                        width: 14,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.4),
                      ),
                    ),
                    suffixIcon: controller.isActiveSuffixIcon
                        ? InkWell(
                            onTap: () => controller.clearSearchController(),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.radiusDefault),
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.4),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
