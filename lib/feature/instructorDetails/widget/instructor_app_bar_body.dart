import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/data/model/instructor/social_link.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/instructor/instructor_profile_data.dart';

class InstructorAppBarBody extends StatelessWidget
    implements PreferredSizeWidget {
  final bool? backButton;
  final InstructorProfileData profileData;
  const InstructorAppBarBody(
      {super.key, this.backButton = true, required this.profileData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(Dimensions.radiusExtraMoreLarge)),
              child: CustomImage(image: profileData.profilePic,height: 75,width: 75,)),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
        Text(
          profileData.name,
          style: robotoSemiBold.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color!,
              fontSize: Dimensions.fontSizeDefault),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Text(
          profileData.designation,
          style: robotoRegular.copyWith(
              color: Get.isDarkMode
                  ? Colors.green
                  : Theme.of(context).primaryColor,
              fontSize: Dimensions.fontSizeExtraSmall),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            profileData.about,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: robotoRegular.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.5),
                fontSize: Dimensions.fontSizeSmall),
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        socialMediaWidget()
      ],
    );
  }

  Row socialMediaWidget() {
    List<Widget> widgets = [];
    widgets.addAll(
        profileData.socialLinks!.map((link) => socialMediaItem(link)).toList());
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: widgets);
  }

  Widget socialMediaItem(SocialLink socialLink) {
    if (socialLink.name.toLowerCase().contains("facebook")) {
      return InkWell(
        onTap: (){
          _launchUrl(Uri.parse(socialLink.link));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(Images.facebook, height: 15),
        ),
      );
    } else if (socialLink.name.toLowerCase().contains("twitter")) {
      return InkWell(
        onTap: (){
          _launchUrl(Uri.parse(socialLink.link));

        },
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(Images.twitter, height: 15),
        ),
      );
    } else if (socialLink.name.toLowerCase().contains("instagram")) {
      return InkWell(
        onTap: (){
          _launchUrl(Uri.parse(socialLink.link));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(Images.instagram, height: 15),
        ),
      );
    } else if (socialLink.name.toLowerCase().contains("linkedin")) {
      return InkWell(
        onTap: (){
          _launchUrl(Uri.parse(socialLink.link));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: SvgPicture.asset(Images.linkedin, height: 15),
        ),
      );
    }
    return const SizedBox();
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(210);
}
