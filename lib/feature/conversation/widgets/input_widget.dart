import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/localization_controller.dart';
import 'package:lms_user_app/utils/images.dart';

class InputWidget extends StatelessWidget {
  InputWidget({
    super.key,
    required this.onSendPressed,
    required this.onAttatchmentButtonPressed,
    required this.inputController,
  });
  final TextEditingController inputController;
  final FocusNode _focusNode = FocusNode();
  final Function()? onSendPressed;
  final Function()? onAttatchmentButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.green,
            ),
            onPressed: onAttatchmentButtonPressed,
          ),
          Expanded(child: inputField(context)),
          SizedBox(
            width: 30,
            child:  IconButton(
                iconSize: 10,
                splashRadius: 20,
                icon: Get.find<LocalizationController>().isLtr ?
                RotatedBox(
                  quarterTurns: 2,
                  child:  SvgPicture.asset(Images.sendMessage,
                      height: 20, width: 20),
                ):SvgPicture.asset(Images.sendMessage,
                    height: 20, width: 20),
                onPressed: onSendPressed),
          ),
        ],
      ),
    );
  }

  Widget inputField(BuildContext context) {
    return ConstrainedBox(
      //height: 34,
      constraints: const BoxConstraints(minHeight: 34),
      child: TextField(
        controller: inputController,
        focusNode: _focusNode,
        cursorColor: const Color(0xff333333),
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(fontSize: 12, color: Colors.black),
        onSubmitted: (value) {
          // sendMessage();
          //FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: 'type_a_message'.tr,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 12, color: const Color(0xff999999)),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff333333), width: 0.6)),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Color(0xff333333), width: 0.6)),
        ),
      ),
    );
  }
}
