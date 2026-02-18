import 'package:flutter/material.dart';

import '../utils/constants.dart';

class UploadImageForm extends StatelessWidget {
  final String? imageUrl;
  final VoidCallback onTap;
  final String title;
  final String? imageFromDevice;
  const UploadImageForm({
    super.key,
    required this.title,
    this.imageUrl,
    required this.onTap,
    this.imageFromDevice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: kSubtitle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: disable,
            ),
          ),
          gapH8,
          Container(
            width: double.infinity,
            height: 156,
            margin: const EdgeInsets.only(bottom: 0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: lineForm),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Visibility(
                          visible: (imageUrl != null),
                          replacement: Container(),
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imageUrl ?? ''),
                                fit: BoxFit.cover,
                              ),
                              border: Border.all(color: lineForm),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        (imageFromDevice != null)
                            ? Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(imageFromDevice!),
                                    fit: BoxFit.cover,
                                  ),
                                  border: Border.all(color: lineForm),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )
                            : Container(),
                        Visibility(
                          visible:
                              (imageUrl == null && imageFromDevice == null),
                          replacement: Container(),
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: lineForm,
                              border: Border.all(color: lineForm),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.image_outlined,
                                    color: fontColorHint,
                                    size: 26,
                                  ),
                                  gapH4,
                                  Text(
                                    "Upload Photo",
                                    style: kSubtitle.copyWith(
                                      color: fontColorHint,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
