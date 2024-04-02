import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/search_controller.dart' as lms_search;
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<lms_search.SearchController>(
      builder: (searchController) {
        return Center(
            child: Padding(
                padding: const EdgeInsets.only(
                    top: 5.0,
                    left: Dimensions.paddingSizeDefault,
                    right: Dimensions.paddingSizeDefault),
                child: Container(
                    height: Dimensions.searchBerSize,
                    width: 350,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(
                            25,
                          ),
                          left: Radius.circular(25)),
                      boxShadow: Get.isDarkMode ? null : searchBoxShadow,
                    ),
                    child: TextField(
                      controller: searchController.searchController,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                      cursorColor: Theme.of(context).hintColor,
                      autofocus: false,
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 22),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(
                                25,
                              ),
                              left: Radius.circular(25)),
                          borderSide:
                              BorderSide(style: BorderStyle.none, width: 0),
                        ),
                        fillColor: Get.isDarkMode
                            ? Theme.of(context).primaryColorDark
                            : const Color(0xffFEFEFE),
                        isDense: true,
                        hintText: 'search_course'.tr,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).hintColor),
                        filled: true,
                        prefixIconConstraints:
                            const BoxConstraints(minWidth: 23, maxHeight: 20),
                        suffixIcon: searchController.isActiveSuffixIcon
                            ? IconButton(
                                color: Theme.of(context).primaryColor,
                                onPressed: () {
                                  if (searchController.searchController.text
                                      .trim()
                                      .isNotEmpty) {
                                    searchController.clearSearchController();
                                  }
                                  FocusScope.of(context).unfocus();
                                },
                                icon: const Icon(Icons.cancel_outlined),
                              )
                            : const SizedBox(),
                      ),
                      onChanged: (text) =>
                          searchController.showSuffixIcon(context, text),
                      onSubmitted: (text) {
                        if (text.isNotEmpty) {
                          searchController.searchData(text);
                        }
                      },
                    ))));
      },
    );
  }
}
