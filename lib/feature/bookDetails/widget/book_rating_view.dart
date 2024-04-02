import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/feature/bookDetails/widget/post_review.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../components/custom_text_field.dart';
import '../../../components/loading_indicator.dart';
import '../../../controller/book_detail_controller.dart';
import '../../../data/model/book_detail/rating.dart';
import '../../../utils/images.dart';

class BookRatingView extends StatefulWidget {
  final Rating rating;
  final bool canReview;
  final int id;
  const BookRatingView(
      {Key? key,
      required this.rating,
      required this.id,
      required this.canReview})
      : super(key: key);

  @override
  State<BookRatingView> createState() => _BookRatingViewState();
}

class _BookRatingViewState extends State<BookRatingView> {
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'book_review'.tr,
                style: robotoSemiBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              if (widget.canReview == true)
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.06),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radiusSmall),
                      bottomLeft: Radius.circular(Dimensions.radiusSmall),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => Get.dialog(PostReview(id: widget.id)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeSmall,
                          vertical: Dimensions.paddingSizeRadius),
                      child: Text(
                        'write_review'.tr,
                        style: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeDefault),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: SizedBox(
            height: 128,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.06),
                    width: 1),
                borderRadius: const BorderRadius.all(
                  Radius.circular(Dimensions.radiusSmall),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.rating.avgRating ?? '0.0',
                          style: robotoBold.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeDefault),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Text(
                          "Out of 5",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .color!
                                  .withOpacity(0.6),
                              fontSize: Dimensions.fontSizeExtraSmall),
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 1,
                      child: Divider(
                        thickness: 1,
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.06),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ratingWidget(context, widget.rating.fiveStar ?? 0, 5),
                        ratingWidget(context, widget.rating.fourStar ?? 0, 4),
                        ratingWidget(context, widget.rating.threeStar ?? 0, 3),
                        ratingWidget(context, widget.rating.twoStar ?? 0, 2),
                        ratingWidget(context, widget.rating.oneStar ?? 0, 1),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showReviewDialog({required BuildContext context, required int id}) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeDefault,
                vertical: Dimensions.paddingSizeExtraSmall),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'rating'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: SvgPicture.asset(
                          Images.cancel,
                          height: Dimensions.paddingSizeRadius,
                          width: Dimensions.paddingSizeRadius,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                GetBuilder<BookDetailController>(
                    id: '_dialog',
                    builder: (controller) {
                      return Container(
                        alignment: Alignment.center,
                        height: 12,
                        width: 78,
                        child: RatingBar.builder(
                          initialRating: 0.0,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: false,
                          itemCount: 5,
                          itemSize: 15,
                          itemBuilder: (context, _) =>
                              const Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: (rating) {
                            controller.updateRatingValue(rating);
                          },
                        ),
                      );
                    }),
                const SizedBox(height: Dimensions.paddingSizeLarge),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'review'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: Dimensions.fontSizeDefault),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                    Container(
                      //height: 44,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.06),
                        ),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.paddingSizeExtraSmall)),
                      ),
                      child: CustomTextField(
                        hintText: 'write_something'.tr,
                        controller: messageController,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeExtraLarge),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          if (messageController.text.isNotEmpty) {
                            await Get.put(BookDetailController())
                                .writeReview(
                                    id: id,
                                    comment: messageController.text,
                                    rating: Get.find<BookDetailController>()
                                        .ratingValue)
                                .then((value) => Get.back());
                          }
                        },
                        child: Container(
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSmall)),
                          child: GetBuilder<BookDetailController>(
                              id: '_dialog',
                              builder: (detailController) {
                                return detailController.isWriteReviewLoading ==
                                        true
                                    ? const LoadingIndicator(
                                        color: Colors.white)
                                    : Text('post_review'.tr,
                                        style: robotoRegular.copyWith(
                                            color: Theme.of(context)
                                                .primaryColorLight,
                                            fontSize:
                                                Dimensions.fontSizeSmall));
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ratingWidget(BuildContext context, int reviewCount, int starCount) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 12,
          //width: 78,
          child: RatingBar.builder(
            initialRating: starCount.toDouble(),
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
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        SizedBox(
          width: 145,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: LinearProgressIndicator(
              minHeight: 6,
              value: calculatePercentage(reviewCount),
              valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.outline),
              backgroundColor: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06),
            ),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        SizedBox(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(reviewCount.toString(),
                style: robotoMedium.copyWith(
                    fontSize: Dimensions.fontSizeSmall,
                    color: Theme.of(context).primaryColor)),
          ),
        ),
      ],
    );
  }

  double calculatePercentage(int reviewCount) {
    return reviewCount == 0
        ? 0.0
        : (reviewCount * 100) / widget.rating.totalReview! / 100;
  }
}
