import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../core/helper/help_me.dart';
import '../../data/model/common/book.dart';

class BookWidget extends StatelessWidget {
  final BookModel book;
  const BookWidget({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouteHelper.bookDetailsScreen, arguments: book.id);
        // Navigator.of(context)
        //     .pushNamed(RouteHelper.bookDetailsScreen, arguments: book.id);
      },
      child: Container(
        width: 155,
        height: 230,
        decoration: BoxDecoration(
            border: Border.all(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.06)),
            borderRadius: const BorderRadius.all(Radius.circular(6))),
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                child: Image.network(
                  book.thumbnail ?? "",
                  width: 80,
                  height: 120,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset(Images.placeholder),
                ),
              ),
              SizedBox(height: Dimensions.fontSizeSmall),
              RatingBar.builder(
                initialRating: double.parse(book.totalRating.toString()),
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                ignoreGestures: true,
                itemCount: 5,
                itemSize: 12,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Colors.amber),
                onRatingUpdate: (rating) {
                  //print(rating);
                },
              ),
              const SizedBox(height: Dimensions.paddingSizeRadius),
              Text(
                book.title ?? "",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: robotoMedium.copyWith(
                    height: 1.2,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: Dimensions.fontSizeSemiSmall),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    calculateBookPrice(book),
                    style: robotoSemiBold.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                  ),
                  const SizedBox(
                    width: Dimensions.paddingSizeSmall,
                  ),
                  if (book.isFree == false)
                    Text(
                      "\$${book.price}",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          decoration: TextDecoration.lineThrough,
                          fontSize: Dimensions.fontSizeExtraSmall),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
