import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:labamu/core/theme/app_colors.dart';

class DropdownOption {
  DropdownOption({required this.value, required this.label});

  final String value;
  final String label;
}

class BaseDropdownButton extends StatelessWidget {
  const BaseDropdownButton({
    super.key,
    this.label = '',
    this.items,
    this.hintText,
    this.onChanged,
    this.validator,
    this.value,
  });

  final String label;

  final String? hintText;
  final String? value;
  final List<DropdownOption>? items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: GoogleFonts.urbanist(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
        ],
        DropdownButtonFormField<String>(
          initialValue: value,
          style: GoogleFonts.urbanist(color: AppColors.textPrimary),
          dropdownColor: AppColors.bgBody,
          elevation: 1,
          borderRadius: BorderRadius.circular(6.r),
          isExpanded: true,
          hint: Text(
            hintText ?? '',
            style: GoogleFonts.urbanist(color: AppColors.textPlaceholder),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.urbanist(
              color: AppColors.textPlaceholder,
              fontSize: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderBase),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.borderBase),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.primary60),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppColors.saError),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                width: 1.2,
                color: AppColors.saError,
              ),
            ),
          ),
          items: items
              ?.map<DropdownMenuItem<String>>(
                (el) =>
                    DropdownMenuItem(value: el.value, child: Text((el).label)),
              )
              .toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
