import 'package:flutter/material.dart';
import 'package:labamu/common/constants/app_colorss.dart';
import 'package:labamu/core/theme/app_colors.dart';

import '../../../../core/utils/constants.dart';
import 'custom_input_field.dart';

class CustomInputText extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? isCustom;
  final int? maxLines;

  const CustomInputText({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.isCustom = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kSubtitle.copyWith(
              color: (isCustom == true) ? white : AppColors.textTertiary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 10),
          CustomInputField(
            controller: controller,
            hintText: hintText,
            isCustom: isCustom,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            maxLines: maxLines,
          ),
        ],
      ),
    );
  }
}
