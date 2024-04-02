import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_text_field.dart';
import 'package:lms_user_app/components/loading_indicator.dart';
import 'package:lms_user_app/controller/book_detail_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class PostReview extends StatelessWidget {
  final int id;
  const PostReview({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      // <-- SEE HERE
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      children: <Widget>[
        GetBuilder<BookDetailController>(
            id: "_dialog",
            builder: (controller) {
              return Padding(
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
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                    Container(
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
                    ),
                    const SizedBox(height: Dimensions.paddingSizeLarge),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'review'.tr,
                          style: robotoMedium.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
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
                                Radius.circular(
                                    Dimensions.paddingSizeExtraSmall)),
                          ),
                          child: CustomTextField(
                            hintText: 'write_something'.tr,
                            controller: controller.messageController,
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
                              if (controller
                                  .messageController.text.isNotEmpty) {
                                await controller.writeReview(
                                    id: id,
                                    comment: controller.messageController.text,
                                    rating: controller.ratingValue);
                              }
                            },
                            child: Container(
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusSmall)),
                              child: controller.isWriteReviewLoading == true
                                  ? const LoadingIndicator(color: Colors.white)
                                  : Text('post_review'.tr,
                                      style: robotoRegular.copyWith(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontSize: Dimensions.fontSizeSmall)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}
