import 'package:country_code_picker/country_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/localization_controller.dart';
import 'package:lms_user_app/utils/dimensions.dart';
import 'package:lms_user_app/utils/styles.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final bool? isPassword;
  final bool? isShowBorder;
  final bool? isAutoFocus;
  final Function(String)? onSubmit;
  final bool? isEnabled;
  final int? maxLines;
  final bool? isShowSuffixIcon;
  final TextCapitalization? capitalization;
  final Function(String text)? onChanged;
  final String? countryDialCode;
  final String? suffixIconUrl;
  final Function(CountryCode countryCode)? onCountryChanged;
  final Widget? prefixIcon;
  final double? borderRadius;
  final Color? fillColor;
  final String? Function(String?)? onValidate;

  const CustomTextField({
    super.key,
    this.hintText = '',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.isShowSuffixIcon = false,
    this.onSubmit,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.isShowBorder = false,
    this.isAutoFocus = false,
    this.countryDialCode,
    this.onCountryChanged,
    this.suffixIconUrl,
    this.onChanged,
    this.onValidate,
    this.prefixIcon,
    this.borderRadius = Dimensions.radiusSmall,
    this.fillColor,
    this.title,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: robotoRegular.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color: widget.isEnabled == false
              ? Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.6)
              : Theme.of(context).textTheme.bodyLarge!.color),
      textInputAction: widget.inputAction,
      keyboardType: widget.inputType,
      cursorColor: Theme.of(context).hintColor,
      textCapitalization: widget.capitalization!,
      enabled: widget.isEnabled,
      autofocus: widget.isAutoFocus!,
      autofillHints: widget.inputType == TextInputType.name
          ? [AutofillHints.name]
          : widget.inputType == TextInputType.emailAddress
              ? [AutofillHints.email]
              : widget.inputType == TextInputType.phone
                  ? [AutofillHints.telephoneNumber]
                  : widget.inputType == TextInputType.streetAddress
                      ? [AutofillHints.fullStreetAddress]
                      : widget.inputType == TextInputType.url
                          ? [AutofillHints.url]
                          : widget.inputType == TextInputType.visiblePassword
                              ? [AutofillHints.password]
                              : null,
      obscureText: widget.isPassword! ? _obscureText : false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          borderSide: const BorderSide(style: BorderStyle.none, width: 0),
        ),
        isDense: true,
        filled: true,
        fillColor: widget.fillColor ?? Theme.of(context).cardColor,
        contentPadding: EdgeInsets.all(Get.find<LocalizationController>().isLtr
            ? Dimensions.paddingSizeSmall
            : Dimensions.paddingSizeExtraSmall),
        hintText: widget.hintText,
        hintStyle: robotoRegular.copyWith(
          fontSize: Dimensions.fontSizeDefault,
          color:
              Theme.of(context).hintColor.withOpacity(Get.isDarkMode ? .5 : 1),
        ),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword!
            ? IconButton(
                splashRadius: 20,
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).hintColor.withOpacity(0.3)),
                onPressed: _toggle,
              )
            : null,
      ),
      onFieldSubmitted: (text) => widget.nextFocus != null
          ? FocusScope.of(context).requestFocus(widget.nextFocus)
          : widget.onSubmit != null
              ? widget.onSubmit!(text)
              : null,
      onChanged: widget.onChanged,
      validator: widget.onValidate != null ? widget.onValidate! : null,
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
