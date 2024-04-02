import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../data/model/quiz/questions.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';

class LabeledCheckbox extends StatefulWidget {
  const LabeledCheckbox(
      {super.key,
      required this.question,
      required this.isCorrectAnsSelected,
      this.selectedIndexes,
      this.isClickable = true,
      this.resultIndexes});
  final Questions question;
  final ValueChanged<bool> isCorrectAnsSelected;
  final ValueChanged<List<int>>? selectedIndexes;
  final bool? isClickable;
  final List<int>? resultIndexes;

  @override
  State<LabeledCheckbox> createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  List<int> valueList = [];
  List<int> selectedIndexes = [];

  @override
  void initState() {
    valueList =
        List.filled(widget.question.option?.length ?? 0, -1, growable: true);
    //result index 1 is for common value if list is empty
    if (widget.isClickable == false && widget.resultIndexes!.length != 1) {
      if (widget.resultIndexes!.isNotEmpty) {
        valueList = widget.resultIndexes!;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.question.question,
                style: robotoRegular.copyWith(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                  children: List.generate(
                      widget.question.option!.length,
                      (index) => CustomCheckBox(
                            label: widget.question.option![index].answer,
                            value: valueList[index] == index,
                            onChanged: (value) {
                              if (widget.isClickable == true) {
                                handleCheckBoxChanged(value, index);
                              }
                            },
                          ))),
            ],
          ),
        ),
      ),
    );
  }

  void handleCheckBoxChanged(bool? value, int index) {
    setState(() {
      if (value!) {
        valueList[index] = index;
        selectedIndexes.add(index);
      } else {
        valueList[index] = -1;
        selectedIndexes.remove(index);
      }
    });

    //check ans is true or false
    // first make 2 lists ascending order
    selectedIndexes.sort();
    widget.question.correctAnswerIndex?.sort();
    if (listEquals(selectedIndexes, widget.question.correctAnswerIndex)) {
      widget.isCorrectAnsSelected(true);
    } else {
      widget.isCorrectAnsSelected(false);
    }
    if (widget.selectedIndexes != null) {
      widget.selectedIndexes!(valueList);
    }
  }
}

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged});
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              onChanged(newValue!);
            },
          ),
        ),
        Expanded(
            child: Text(label,
                style: robotoRegular.copyWith(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                  fontSize: Dimensions.fontSizeSmall,
                ))),
      ],
    );
  }
}
