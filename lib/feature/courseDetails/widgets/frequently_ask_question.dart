import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../data/model/course_detail/faq.dart';

class FrequentlyAskQuestion extends StatelessWidget {
  final List<Faq> faqList;
  const FrequentlyAskQuestion({Key? key, required this.faqList})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Text(
            'frequently_ask_question'.tr,
            style: robotoSemiBold.copyWith(fontSize: Dimensions.fontSizeDefault),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
              alignment: Alignment.center,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: faqList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return faqItem(context, faqList[index]);
                  })),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Padding faqItem(BuildContext context, Faq faq) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.03),
            width: 1,
          ),
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(Dimensions.radiusSmall),
          ),
        ),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ),
          title: Text(
            faq.question ?? '',
            style: robotoMedium.copyWith(
                color: Theme.of(context).textTheme.bodyLarge!.color!,
                fontSize: Dimensions.fontSizeSmall),
          ),
          children: [
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06),
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.paddingSizeSmall,
                        horizontal: Dimensions.paddingSizeDefault),
                    child: Html(
                      data: faq.answer ?? '',
                      style: {
                        "p": Style(
                          fontSize: FontSize.medium,
                        ),
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = Dimensions.radiusSmall;
        final dashHeight = height;
        final dashCount = (boxWidth / (1.5 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
