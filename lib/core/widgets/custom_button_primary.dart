import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';

class CustomButtonPrimary extends StatelessWidget {
  final bool isEnable;
  final String title;
  final VoidCallback onTap;
  final String? icon;
  final Color? color;
  final Color? textColor;

  const CustomButtonPrimary({
    super.key,
    this.isEnable = true,
    required this.onTap,
    required this.title,
    this.color,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: GestureDetector(
        onTap: isEnable ? onTap : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: (isEnable == false) ? darkGreyThird : color ?? primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: (icon != null) ? true : false,
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: SvgPicture.asset(icon.toString())),
              ),
              Text(
                title,
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: kSubtitle.copyWith(
                  color: textColor ?? white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
