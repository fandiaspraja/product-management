import 'package:flutter/material.dart';
import 'package:labamu/core/utils/constants.dart';

class ImagePickerDialog extends StatelessWidget {
  final VoidCallback cameraTap;
  final VoidCallback galleryTap;

  const ImagePickerDialog({
    super.key,
    required this.cameraTap,
    required this.galleryTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            GestureDetector(
              onTap: cameraTap,
              child: Text(
                'Camera',
                style: kHeading5.copyWith(
                  color: fontColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: galleryTap,
              child: Text(
                'Gallery',
                style: kHeading5.copyWith(
                  color: fontColorPrimary,
                  fontWeight: FontWeight.w600,
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
