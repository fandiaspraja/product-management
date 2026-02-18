import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/constants.dart';

class CustomOutlinedTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? title;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? isCustom;
  final bool? isEnable;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputFormatter? formatter;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onValueChange;

  const CustomOutlinedTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,
    this.isEnable = true,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.isCustom = false,
    this.maxLines = 1,
    this.formatter,
    this.onFieldSubmitted,
    this.onValueChange,
    this.maxLength,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        maxLines: maxLines,
        enabled: isEnable,
        maxLength: maxLength,
        minLines: minLines,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: false,
        onChanged: (value) {
          onValueChange?.call(value);
        },
        buildCounter: (BuildContext context,
            {int? currentLength, bool? isFocused, int? maxLength}) {
          if (maxLength == null || currentLength == null) {
            return null;
          }
          return Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              '$currentLength/$maxLength',
              style: kSubtitle.copyWith(
                color: darkGreyThird,
                fontSize: 10,
              ),
              semanticsLabel: 'character count',
            ),
          );
        },
        inputFormatters: [
          if (formatter != null) formatter!,
        ],
        style: kSubtitle.copyWith(
          color: fontColorPrimary,
          fontSize: 11,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 12.0), // Minimal padding

          labelText: "$title",
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17),
          ),
          hintStyle: kSubtitle.copyWith(
            color: darkGreyThird,
            fontSize: 11,
          ),
          labelStyle: kSubtitle.copyWith(
            color: fontColorPrimary,
            fontSize: 11,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primary),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: lineForm),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: red),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
