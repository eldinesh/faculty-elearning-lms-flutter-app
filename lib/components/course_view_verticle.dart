import 'package:flutter/material.dart';
import 'package:lms_user_app/core/helper/responsive_helper.dart';
import 'package:lms_user_app/feature/common/course_widget.dart';
import 'package:lms_user_app/feature/root/view/no_data_screen.dart';
import 'package:lms_user_app/utils/dimensions.dart';

class ServiceViewVertical extends StatelessWidget {
  final List<dynamic>? service;
  final EdgeInsetsGeometry? padding;
  final bool? isScrollable;
  final int? shimmerLength;
  final String? noDataText;
  final String? type;
  final NoDataType? noDataType;
  final Function(String type)? onVegFilterTap;

  const ServiceViewVertical(
      {super.key,
      required this.service,
      this.isScrollable = false,
      this.shimmerLength = 20,
      this.padding = const EdgeInsets.all(Dimensions.paddingSizeSmall),
      this.noDataText,
      this.type,
      this.onVegFilterTap,
      this.noDataType});

  @override
  Widget build(BuildContext context) {
    bool isNull = true;

    isNull = service == null;
    if (!isNull) {}

    return GridView.builder(
      key: UniqueKey(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: Dimensions.paddingSizeDefault,
        mainAxisSpacing: Dimensions.paddingSizeDefault,
        childAspectRatio: ResponsiveHelper.isTab(context) ? .9 : .63,
        mainAxisExtent: ResponsiveHelper.isMobile(context) ? 225 : 260,
        crossAxisCount: ResponsiveHelper.isMobile(context)
            ? 2
            : ResponsiveHelper.isTab(context)
                ? 3
                : 5,
      ),
      physics: isScrollable!
          ? const ScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      // shrinkWrap: isScrollable! ? false : true,
      // physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: service?.length,
      padding: padding,
      itemBuilder: (context, index) {
        return CourseWidget(course: service?.elementAt(index));
      },
    );
  }
}
