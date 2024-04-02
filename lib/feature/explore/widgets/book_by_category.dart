import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';
import '../../../data/model/explore.dart';
import '../../common/book_widget.dart';

class BookByCategoryWidget extends StatelessWidget {
  final Explore explore;
  const BookByCategoryWidget({Key? key, required this.explore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Text(
            'book_by_category'.tr,
            style:
                robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        const SizedBox(
          height: Dimensions.paddingSizeDefault,
        ),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: explore.data?.books?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  right: Dimensions.paddingSizeDefault,
                  left: index == 0 ? Dimensions.paddingSizeDefault : 0,
                ),
                child: BookWidget(
                  book: explore.data!.books!.elementAt(index),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
