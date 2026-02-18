import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? isCustom;
  final String? suffixIcon;
  final isEnable;
  final int? maxLines;
  final Function(String)? onChange;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.isCustom = false,
    this.suffixIcon,
    this.isEnable = true,
    this.validator,
    this.maxLines,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: false,
        maxLines: maxLines,
        style: kSubtitle.copyWith(
          color: fontColorPrimary,
          fontSize: 11,
        ),
        onChanged: (val) => onChange?.call(val),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          enabled: isEnable,
          suffixIcon: (suffixIcon != null)
              ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    suffixIcon!,
                    width: 20,
                    height: 20,
                  ),
                )
              : null,
          fillColor: (isCustom == true) ? white : bgImageForm,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryThird),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: lineForm),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: lineForm),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: red),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: kSubtitle.copyWith(
            color: darkGreyThird,
            fontSize: 11,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
