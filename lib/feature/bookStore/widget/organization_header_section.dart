import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lms_user_app/data/model/organization_detail/organization_profile.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class OrganizationHeaderSection extends StatelessWidget {
  final OrganizationProfileData data;
  const OrganizationHeaderSection({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Color(
          int.parse(data.brandColor!.substring(1, 7), radix: 16) + 0xFF000000),
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -40,
            child: Container(
              width: 90.0,
              height: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(
                    int.parse(data.brandColor!.substring(1, 7), radix: 16) +
                        0xFF000000),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.0,
                ),
              ),
              child: Center(
                child: Container(
                  width: 78.0,
                  height: 78.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(data.logo ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).viewPadding.top +
                      MediaQuery.of(context).viewPadding.top -
                      10),
              Text(
                data.name ?? "",
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Theme.of(context).cardColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                  width: 200,
                  child: Text(
                    data.address ?? "",
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeExtraSmall,
                      color: Theme.of(context).cardColor,
                    ),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(
                height: Dimensions.paddingSizeRadius,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 12,
                    width: 72,
                    child: RatingBar.builder(
                      initialRating: double.parse(data.rating ?? "0.0"),
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
                  Text(
                    "${data.totalReview} rating",
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeExtraSmall,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60)
            ],
          ),
        ],
      ),
    );
  }
}
