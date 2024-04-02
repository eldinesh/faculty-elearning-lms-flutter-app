import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';

class FeaturedCourseItem extends StatelessWidget {
  const FeaturedCourseItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return  Container(
      width: width / 1.2,
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColorLight),
          borderRadius: const BorderRadius.all(Radius.circular(6))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(6),bottomLeft: Radius.circular(6),),
            child: Image.asset(Images.placeholder,width: 120,height: 120,fit: BoxFit.fitHeight,),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mathematics with Animated Lessons..",style: robotoMedium.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: Dimensions.fontSizeDefault),),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(Images.playSmall),
                            const SizedBox(width: Dimensions.paddingSizeMint,),
                            Text("45 Lessons",style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),)
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(Images.profileSmall),
                            const SizedBox(width: Dimensions.paddingSizeMint,),
                            Text("45 Lessons",style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall),)
                          ],
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$27.00",style: robotoRegular.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeSmall),),
                      Row(
                        children: [
                          SvgPicture.asset(Images.starFill),
                          const SizedBox(width: Dimensions.paddingSizeMint,),
                          Text("4.5",style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),);
  }
}
