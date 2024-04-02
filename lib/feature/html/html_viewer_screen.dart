import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_app_bar.dart';
import 'package:lms_user_app/controller/html_view_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/html_type.dart';

class HtmlViewerScreen extends StatelessWidget {
  final HtmlType? htmlType;
  const HtmlViewerScreen({super.key, required this.htmlType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: htmlType == HtmlType.termsAndConditions
              ? 'terms_and_conditions'.tr
              : htmlType == HtmlType.aboutUs
                  ? 'about_us'.tr
                  : htmlType == HtmlType.privacyPolicy
                      ? 'privacy_policy'.tr
                      : htmlType == HtmlType.helpAndSupport
                          ? 'help_and_support'.tr
                          : 'no_data_found'.tr),
      body: GetBuilder<HtmlViewController>(
        initState: (state) => Get.find<HtmlViewController>().getPagesContent(),
        builder: (htmlViewController) {
          String? data;
          if (htmlViewController.isLoading == false ||  htmlViewController.pagesContent != null) {
            data = htmlType == HtmlType.termsAndConditions
                ? htmlViewController
                    .pagesContent?.termsAndConditions?.description
                : htmlType == HtmlType.aboutUs
                    ? htmlViewController.pagesContent?.aboutUs?.description
                    : htmlType == HtmlType.privacyPolicy
                        ? htmlViewController
                            .pagesContent?.privacyPolicy?.description
                        : htmlType == HtmlType.helpAndSupport
                            ? htmlViewController
                                .pagesContent?.helpAndSupport?.description
                            : null;

            if (data != null) {
              data = data.replaceAll('href=', 'target="_blank" href=');

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Get.height,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(
                    Dimensions.paddingSizeSmall,
                  ),
                  physics: const BouncingScrollPhysics(),
                  child: Html(
                    data: data,
                    style: {
                      "p": Style(
                        fontSize: FontSize.medium,
                      ),
                    },
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
