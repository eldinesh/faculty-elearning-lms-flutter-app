import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

import '../../../data/model/book_detail/summary.dart';

class SummaryWidget extends StatelessWidget {
  final Summary summary;
  const SummaryWidget({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeDefault),
          child: Text('summary'.tr,
              style: robotoSemiBold.copyWith(
                  fontSize: Dimensions.fontSizeDefault)),
        ),
        if (summary.description != "")
          const SizedBox(height: Dimensions.paddingSizeDefault),
        if (summary.description != "")
          summary.description!.length > 100
              ? const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeDefault),
                  child: ExpandableText(
                    //summary.description ?? '',
                    'hello',
                    trimLines: 2,
                  ),
                )
              : Text(summary.description ?? ''),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Table(
              columnWidths: const {
                0: FixedColumnWidth(155.0), // fixed to 100 width
                1: FlexColumnWidth(),
              },
              border: TableBorder.all(
                  color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(
                      0.06)), // Allows to add a border decoration around your table
              children: [
                TableRow(children: [
                  SizedBox(
                    width: 13,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                      child: Text(
                        'title'.tr,
                        style: robotoMedium.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.6),
                            fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      summary.title ?? '',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'author'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      summary.author ?? '',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'publisher'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      summary.publisher ?? '',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'edition'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      summary.edition ?? '',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'page'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      '${summary.page} page',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'country'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      summary.country ?? '',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'language'.tr,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      summary.language ?? '',
                      style: robotoRegular.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .color!
                              .withOpacity(0.6),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ]),
              ]),
        ),
      ],
    );
  }
}

class ExpandableText extends StatefulWidget {
  const ExpandableText(
    this.text, {
    Key? key,
    this.trimLines = 2,
  }) : super(key: key);

  final String text;
  final int trimLines;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
        text: _readMore ? 'see_more'.tr : 'read_less'.tr,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.4),
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        final text = TextSpan(
          text: widget.text,
        );

        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );

        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));

        endIndex = textPainter.getOffsetBefore(pos.offset)!;
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.6),
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
