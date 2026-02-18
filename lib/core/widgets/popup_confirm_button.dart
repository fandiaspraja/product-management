import 'package:flutter/material.dart';
import 'package:labamu/core/utils/constants.dart';

class PopupConfirmButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onTap;
  final double width;

  const PopupConfirmButton({
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
                  color: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26.42),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x2D151414),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                      spreadRadius: 0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: kHeading6.copyWith(
                  color: white,
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
