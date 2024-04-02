import 'package:flutter/material.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String? buttonText;
  final bool? transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double? radius;
  final IconData? icon;

  const CustomButton(
      {super.key,
      this.onPressed,
      @required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed != null
          ? Theme.of(context).primaryColor
          : transparent!
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(
          width != null ? width! : MediaQuery.of(context).size.width,
          height != null ? height! : 45),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
      ),
    );

    return Center(
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        child: Padding(
          padding: margin == null ? const EdgeInsets.all(0) : margin!,
          child: TextButton(
            onPressed: onPressed,
            style: flatButtonStyle,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              icon != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          right: Dimensions.paddingSizeExtraSmall,
                          left: Dimensions.paddingSizeExtraSmall),
                      child: Icon(
                        icon,
                        color: transparent!
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        size: 18,
                      ),
                    )
                  : const SizedBox(),
              Text(buttonText ?? '',
                  textAlign: TextAlign.center,
                  style: robotoMedium.copyWith(
                    color: transparent!
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    fontSize: fontSize ?? Dimensions.fontSizeDefault,
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}
