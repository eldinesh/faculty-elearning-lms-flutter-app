import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/ripple_button.dart';
import 'package:lms_user_app/controller/search_controller.dart' as lms_search;
import 'package:lms_user_app/core/helper/responsive_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class SearchSuggestion extends StatelessWidget {
  const SearchSuggestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<lms_search.SearchController>(builder: (searchController) {
      return Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'suggestions'.tr,
                  style: robotoMedium.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).primaryColor),
                ),
                InkWell(
                  onTap: () {
                    searchController.clearSearchAddress();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Text(
                      'clear_all'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Dimensions.paddingSizeDefault,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isTab(context) ? 6 : 4,
                childAspectRatio: 3 / 1.6,
                crossAxisSpacing: Dimensions.paddingSizeDefault,
                mainAxisSpacing: Dimensions.paddingSizeDefault,
              ),
              itemCount: searchController.historyList!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).hoverColor,
                            borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.radiusDefault))),
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeExtraSmall,
                              vertical: Dimensions.paddingSizeExtraSmall),
                          child: Text(
                              searchController.historyList!.elementAt(index)),
                        ))),
                    Positioned.fill(child: RippleButton(onTap: () {
                      searchController.populatedSearchController(
                          searchController.historyList!.elementAt(index));
                      searchController.searchData(
                          searchController.historyList!.elementAt(index));
                    }))
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
