import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_image.dart';
import 'package:lms_user_app/controller/home_controller.dart';
import 'package:lms_user_app/controller/theme_controller.dart';
import 'package:lms_user_app/core/helper/responsive_helper.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/images.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:lms_user_app/data/model/home_data_model/slider.dart' as home_slider;
import 'package:url_launcher/url_launcher.dart';

class BannerView extends StatelessWidget {
  final int bannerIndex;
  const BannerView({super.key, required this.bannerIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (bannerController) {
        return (bannerController.homeModel?.data?[bannerIndex].sliders ==
                    null ||
                bannerController.homeModel!.data![bannerIndex].sliders!.isEmpty)
            ? const SizedBox()
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: ResponsiveHelper.isTab(context) ||
                        MediaQuery.of(context).size.width > 450
                    ? 350
                    : MediaQuery.of(context).size.height * 0.25,
                child: bannerController.homeModel?.data?[bannerIndex].sliders !=
                        null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Expanded(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: false,
                                enlargeCenterPage: false,
                                viewportFraction: .90,
                                disableCenter: true,
                                initialPage: 0,
                                autoPlayInterval: const Duration(seconds: 5),
                                onPageChanged: (index, reason) {
                                  bannerController.setCurrentIndex(index, true);
                                },
                              ),
                              items:  bannerController.homeModel!.data![bannerIndex].sliders!.map((e) => sliderItem(context, e, bannerController)).toList(),
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeSmall),
                          Align(
                            alignment: Alignment.center,
                            child: AnimatedSmoothIndicator(
                              activeIndex: bannerController.currentIndex!,
                              //activeIndex: 0,
                              count: bannerController.homeModel!.data![bannerIndex].sliders?.length ??
                                  0,
                              effect: ExpandingDotsEffect(
                                dotHeight: 5,
                                dotWidth: 5,
                                activeDotColor: Get.isDarkMode
                                    ? Colors.green
                                    : Theme.of(context).primaryColor,
                                dotColor: Get.isDarkMode
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                    : Theme.of(context).disabledColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Shimmer(
                        duration: const Duration(seconds: 2),
                        enabled: true,
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                            color: Colors.grey[
                                Get.find<ThemeController>().darkTheme
                                    ? 700
                                    : 300],
                          ),
                        ),
                      ),
              );
      },
    );
  }

  Widget sliderItem(BuildContext context, home_slider.Slider sliders,
      HomeController bannerController) {
    return InkWell(
      onTap: () {
        if(sliders.type != "course"){
          _launchUrl(Uri.parse( sliders.url.toString()));

        }else{
          Get.toNamed(
              RouteHelper.getCourseDetailsScreenRoute(),
              arguments: sliders.courseBookId);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeExtraSmall,
            vertical: Dimensions.paddingSizeExtraSmall),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: CustomImage(
                  image:
                      sliders.image ??
                          "",
                  fit: BoxFit.cover,
                  placeholder: Images.placeholder,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.paddingSizeSmall,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
