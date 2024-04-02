import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/title_view.dart';
import 'package:lms_user_app/core/helper/help_me.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../data/model/common/book.dart';

class Trending extends StatelessWidget {
  final List<BookModel> bookList;
  const Trending({Key? key, required this.bookList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bookList.isEmpty
        ? const SizedBox()
        : SizedBox(
            height: 277,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleView(title: 'trending_of_this_month'.tr),
                const SizedBox(
                  height: Dimensions.paddingSizeDefault,
                ),
                SizedBox(
                  height: 241,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: bookList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return bookItem(bookList[index], index, context);
                      }),
                ),
              ],
            ),
          );
  }

  Widget bookItem(BookModel book, int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: index == 0
            ? Dimensions.paddingSizeDefault
            : Dimensions.paddingSizeExtraSmall,
        right: Dimensions.paddingSizeExtraSmall,
      ),
      child: Container(
        width: 134,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.06)),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6),
                  topRight: Radius.circular(6),
                ),
                child: Image.network(
                  bookList[index].thumbnail ?? '',
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    Images.placeholder,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title ?? '',
                    textAlign: TextAlign.start,
                    style: robotoMedium.copyWith(
                        //height: 1.2,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.6),
                        fontSize: Dimensions.fontSizeSemiSmall),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: Dimensions.paddingSizeRadius,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        calculateBookPrice(book),
                        style: robotoSemiBold.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      if (book.isDiscounted == true)
                        Text(
                          "\$${book.price}",
                          style: robotoRegular.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(.5),
                            fontSize: Dimensions.fontSizeExtraSmall,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
