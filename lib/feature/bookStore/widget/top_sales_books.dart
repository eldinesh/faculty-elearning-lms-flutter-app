import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/utils/dimensions.dart';

class TopSalesBooks extends StatelessWidget {
  const TopSalesBooks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 260,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleView(title: 'top_sales_books'.tr),
          const SizedBox(
            height: Dimensions.paddingSizeDefault,
          ),
          SizedBox(
            height: 220,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        right: index == 20 ? 0 : Dimensions.paddingSizeDefault,
                        left: index == 0 ? Dimensions.paddingSizeDefault : 0),
                    child: const SizedBox(),
                    //child:  BookWidget(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
