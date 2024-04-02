import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/data/model/quiz/questions.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';

class ShortQuestionWidget extends StatefulWidget {
  final Questions question;
  final bool? isDisabled;
  final ValueChanged<String>? onTextChanged;
  const ShortQuestionWidget(
      {super.key,
      required this.question,
      this.isDisabled = false,
      this.onTextChanged});

  @override
  State<ShortQuestionWidget> createState() => _ShortQuestionWidgetState();
}

class _ShortQuestionWidgetState extends State<ShortQuestionWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        width: 290,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.06)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.question.question,
                style: robotoRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller,
                onChanged: (value) => widget.onTextChanged != null
                    ? widget.onTextChanged!(value)
                    : null,
                readOnly: widget.isDisabled ?? false,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withOpacity(0.6)),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(style: BorderStyle.none, width: 0),
                  ),
                  isDense: true,
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  hintText: 'write_your_ans'.tr,
                  hintStyle: robotoRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: Theme.of(context)
                        .hintColor
                        .withOpacity(Get.isDarkMode ? .5 : 1),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
