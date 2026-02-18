import 'package:flutter/material.dart';
import 'package:labamu/core/utils/constants.dart';

class PopupCancelButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onTap;
  final double width;

  const PopupCancelButton({
    super.key,
    required this.color,
    required this.title,
    required this.onTap,
    this.width = 111,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: 36,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: width,
                height: 36,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.50, color: color),
                    borderRadius: BorderRadius.circular(26.42),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 4),
              alignment: Alignment.center,
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: kHeading6.copyWith(
                  color: fontColorPrimary,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
