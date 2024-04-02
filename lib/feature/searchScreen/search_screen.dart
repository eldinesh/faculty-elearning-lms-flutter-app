import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/search_controller.dart' as lms_search;
import 'package:lms_user_app/feature/searchScreen/widget/search_body.dart';
import 'package:lms_user_app/feature/searchScreen/widget/search_field.dart';
import 'package:lms_user_app/feature/searchScreen/widget/search_segregation.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<lms_search.SearchController>().clearSearchController();
        Get.find<lms_search.SearchController>().removeService();
        return true;
      },
      child: Scaffold(
        body: GetBuilder<lms_search.SearchController>(
          builder: (searchController) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SearchField(),
                  // if(searchController.isSearchSegregation)
                  const SearchSegregation(),

                  searchController.isLoading == true
                      ? const SizedBox(height: 200, child: LoadingIndicator())
                      : searchController.searchResultCourseList != null ? searchController.searchResultCourseList!.isEmpty ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        Images.emptySearchResult,
                                        scale: 3,
                                      ),
                                      Text('no_result_found'.tr),
                                      const SizedBox(
                                        height:
                                            Dimensions.paddingSizeExtraSmall,
                                      ),
                                      Text(
                                          'please_try_again_with_another_keywords'
                                              .tr),
                                    ],
                                  ),
                                )
                      : SearchBody(courseList: searchController.searchResultCourseList!) : const SizedBox(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
