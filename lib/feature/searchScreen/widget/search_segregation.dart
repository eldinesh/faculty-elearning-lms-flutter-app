import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:lms_user_app/controller/search_controller.dart' as lms_search;

class SearchSegregation extends StatelessWidget {
  const SearchSegregation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<lms_search.SearchController>(builder: (controller) {
      return Wrap(
        spacing: 1.0,
        direction: Axis.horizontal,
        children: controller.historyList!
            .map((label) => item(context, label, controller))
            .toList(),
      );
    });
  }

  Widget item(BuildContext context, String label,
          lms_search.SearchController controller) =>
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Chip(
          backgroundColor: Theme.of(context).primaryColorLight,
          side: BorderSide.none,
          avatar: SvgPicture.asset(Images.timer),
          label: InkWell(
              onTap: () {
                controller.searchController.text = label;
                controller.searchData(label);
              },
              child: Text(label,style: robotoRegular.copyWith(color: Colors.black54),)),
          labelStyle: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeSmall,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.6)),
          deleteIcon: SvgPicture.asset(Images.cancel),
          onDeleted: () => controller.removeHistory(label),
        ),
      );

  Padding segregationItem(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Images.timer),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("English Course"),
              ),
              SvgPicture.asset(Images.cancel),
            ],
          ),
        ),
      ),
    );
  }
}
