import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

class CustomButtonOutlined extends StatelessWidget {
  final bool isEnable;
  final String title;
  final VoidCallback onTap;
  final bool isSelected;
  final String? icon;

  const CustomButtonOutlined({
    super.key,
    this.isEnable = true,
    required this.onTap,
    required this.title,
    this.isSelected = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isSelected ? primary : lineForm,
              width: 1,
            ),
          ),
        ),
        onPressed: () {
          isEnable ? onTap() : null;
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: kSubtitle.copyWith(
                color: primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Visibility(
              visible: (icon != null) ? true : false,
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset(icon.toString())),
            ),
          ],
        ),
      ),
    );
  }
}
