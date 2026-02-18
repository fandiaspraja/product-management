import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

class ItemMenuAccount extends StatelessWidget {
  final String title;
  final bool isActive;
  final Function onTap;

  const ItemMenuAccount(
      {super.key,
      required this.title,
      this.isActive = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38,
      child: OutlinedButton(
        onPressed: () {
          onTap();
        },
        style: OutlinedButton.styleFrom(
          backgroundColor: isActive ? primaryThird : white,
          side: const BorderSide(
            color: primaryThird,
            width: 1,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: kHeading6.copyWith(
              color: isActive ? white : darkGreyThird,
              fontSize: 14,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
