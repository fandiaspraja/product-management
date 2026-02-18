import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/constants.dart';

class CustomOutlinedDatetime extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? title;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? isCustom;
  final bool isDate;
  final Function onTap;

  const CustomOutlinedDatetime({
    super.key,
    required this.controller,
    required this.hintText,
    this.title,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.isCustom = false,
    this.isDate = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '', style: kSubtitle.copyWith(fontSize: 10)),
        gapH8,
        SizedBox(
          width: double.infinity,
          child: TextFormField(
            onTap: () {
              onTap();
            },
            controller: controller,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            readOnly: true,
            obscureText: false,
            autofocus: true,
            style: kSubtitle.copyWith(fontSize: 11),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4.0,
              ), // Minimal padding
              suffixIcon: isDate
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/icons/ic_calendar.svg'),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/icons/ic_clock.svg'),
                    ),
              // labelText: "$title",
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              hintStyle: kSubtitle.copyWith(fontSize: 11),
              labelStyle: kSubtitle.copyWith(fontSize: 11),
              // focusedBorder: OutlineInputBorder(
              //   borderSide: const BorderSide(color: primaryThird),
              //   borderRadius: BorderRadius.circular(17),
              // ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: lineForm),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: lineForm),
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: red),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
