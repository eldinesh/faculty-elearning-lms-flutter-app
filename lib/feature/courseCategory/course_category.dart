import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/controller/category_controller.dart';
import 'package:lms_user_app/core/helper/responsive_helper.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/common/category.dart';
import 'package:lms_user_app/feature/root/view/no_data_screen.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class CourseCategoryScreen extends StatelessWidget {
  const CourseCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'course_category'.tr,
      ),
      body: GetBuilder<CategoryController>(
        initState: (state) => Get.find<CategoryController>().getCategoryList(),
        builder: (categoryController) {
          List<Category>? categoryList = categoryController.categoryList;
          if (categoryList != null && categoryList.isEmpty) {
            return NoDataScreen(text: 'no_category_found'.tr);
          } else {
            if (categoryList != null) {
              return SingleChildScrollView(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: ResponsiveHelper.isTab(context) ? 4 : 3,
                    childAspectRatio: (1 / 1),
                    mainAxisSpacing: Dimensions.paddingSizeSmall,
                    crossAxisSpacing: Dimensions.paddingSizeSmall,
                  ),
                  padding: const EdgeInsets.all(
                    Dimensions.paddingSizeDefault,
                  ),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        Get.toNamed(RouteHelper.getAllCourseScreen(
                            categoryList.elementAt(index).id.toString(),
                            categoryList.elementAt(index).title ?? ''));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color!
                                    .withOpacity(0.06)),
                            color: Theme.of(context).cardColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            boxShadow: Get.isDarkMode
                                ? null
                                : [
                                    BoxShadow(
                                        color: Colors.grey[Get.isDarkMode ? 800 : 200]!,
                                        blurRadius: 5,
                                        spreadRadius: 1)
                                  ]),
                        alignment: Alignment.center,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSmall),
                                child:  CustomImage(
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                  image: categoryList[index].icon!,
                                ),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                child: Text(
                                  categoryList[index].title!,
                                  textAlign: TextAlign.center,
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).dividerColor,
                                      fontSize: Dimensions.fontSizeSmall),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ]),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
