import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/data/model/book_detail/data.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class BookDetailsHeaderSection extends StatelessWidget {
  final BookDetailData data;
  const BookDetailsHeaderSection({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: Dimensions.paddingSizeLarge),
          SizedBox(
            height: 200,
            width: 135,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                SizedBox(
                  height: 200,
                  width: 135,
                  child: CustomImage(
                    image: data.thumbnail ?? '',
                    placeholder: Images.placeholder,
                  ),
                ),
                if (data.isEbook == true)
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 24,
                      width: 63,
                      alignment: Alignment.center,
                      color: const Color(0xffFF6767),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            Images.pdfFormat,
                            color: Theme.of(context).cardColor,
                          ),
                          const SizedBox(
                            width: Dimensions.paddingSizeExtraSmall,
                          ),
                          Text(
                            "Ebook",
                            style: robotoRegular.copyWith(
                                color: Theme.of(context).cardColor,
                                fontSize: Dimensions.fontSizeExtraSmall),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Text(
            data.title ?? '',
            style: robotoSemiBold.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeLarge),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Text(
            "by ${data.instructor?.name}",
            style: robotoRegular.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeSmall),
          ),
          const SizedBox(height: Dimensions.paddingSizeDefault),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (data.isEbook == false)
                  Row(
                    children: [
                      SizedBox(
                        height: 12,
                        width: 12,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: SvgPicture.asset(Images.successful),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                      Text(
                        'in_stock'.tr,
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: Dimensions.paddingSizeSmall),
                      ),
                      const SizedBox(
                        width: Dimensions.paddingSizeMint,
                      ),
                      Text(
                        "(${data.currentStock})",
                        style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.paddingSizeSmall,
                        ),
                      )
                    ],
                  ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                  child: VerticalDivider(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.6),
                    thickness: 1.5,
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 12,
                      width: 12,
                      child: Icon(
                        Icons.star,
                        size: 12,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      data.avgRatings ?? '0.0',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                          fontSize: Dimensions.paddingSizeSmall),
                    ),
                    const SizedBox(
                      width: Dimensions.paddingSizeExtraSmall,
                    ),
                    Text(
                      "(${data.totalReviews} ${'review'.tr})",
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.paddingSizeSmall),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              thickness: 1,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.06),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.radiusSmall))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(Images.chatWithUs),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Have any Questions?",
                          style: robotoMedium.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: Dimensions.paddingSizeSmall),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Text(
                            "Chat with us",
                            style: robotoMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.paddingSizeSmall),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: Dimensions.paddingSizeLarge),
        ],
      ),
    );
  }
}
