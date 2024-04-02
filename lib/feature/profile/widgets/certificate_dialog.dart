import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/controller/certificate_controller.dart';
import 'package:lms_user_app/data/model/common/course.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:lms_user_app/utils/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificateDialog extends StatelessWidget {
  final Course course;
  const CertificateDialog({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog( // <-- SEE HERE
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: CustomImage(
            image: course.thumbnail!,
          fit: BoxFit.contain,),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Text(course.title!,
            style: robotoMedium.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: Dimensions.fontSizeDefault
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(height: Dimensions.paddingSizeExtraLarge),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                  ),
                  child: InkWell(
                    onTap: ()async{
                      await Get.find<CertificateController>().getCertificateDownloadLink(course.id.toString());
                      try {
                        await launchUrl(Uri.parse(Get.find<CertificateController>().certificateDownloadUrl!),
                            mode:
                            LaunchMode.externalApplication);
                      } catch (e) {
                        Get.showSnackbar(
                            const GetSnackBar(
                              backgroundColor: Colors.red,
                              message: "Can't open link.",
                              maxWidth: 200,
                              duration: Duration(seconds: 3),
                              snackStyle: SnackStyle.FLOATING,
                              margin: EdgeInsets.all(10),
                              borderRadius: 5,
                              isDismissible: true,
                              dismissDirection:
                              DismissDirection.horizontal,
                            ));
                      }
                    },
                    child: Text('download'.tr,
                        style: robotoRegular.copyWith(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: Dimensions.fontSizeSmall
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimensions.cartWidgetSize),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(Images.facebook,height: 15,),
                        SvgPicture.asset(Images.twitter,height: 15),
                        SvgPicture.asset(Images.linkedin,height: 15),
                        SvgPicture.asset(Images.instagram,height: 15),
                        SvgPicture.asset(Images.messenger,height: 15),
                      ],
                    ),
                  )),
            ],
          ),
        ),

      ],
    );
  }
}
