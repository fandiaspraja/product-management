import 'package:flutter/material.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/core/widgets/popup_cancel_button.dart';
import 'package:labamu/core/widgets/popup_confirm_button.dart';

class DefaultDatePicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  const DefaultDatePicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
  });

  @override
  State<DefaultDatePicker> createState() => _DefaultDatePickerState();
}

class _DefaultDatePickerState extends State<DefaultDatePicker> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: SingleChildScrollView(
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 34.0),
              child: StatefulBuilder(
                builder: (context, setState) {
                  String formattedDate = "";
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Select Date",
                              style: kHeading6.copyWith(
                                color: fontColorPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 30),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: primarySecond,
                                // colorScheme: const ColorScheme.light(
                                //   primary: primary,
                                //   onPrimary: white,
                                // ),
                                buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary,
                                ),
                                datePickerTheme: DatePickerThemeData(
                                  dayBackgroundColor:
                                      WidgetStateProperty.resolveWith<Color?>((
                                        states,
                                      ) {
                                        if (states.contains(
                                          WidgetState.selected,
                                        )) {
                                          return Colors
                                              .yellow; // selected date background
                                        }
                                        return null;
                                      }),
                                  dayForegroundColor:
                                      WidgetStateProperty.resolveWith<Color?>((
                                        states,
                                      ) {
                                        if (states.contains(
                                          WidgetState.selected,
                                        )) {
                                          return Colors
                                              .red; // selected date text
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                              child: CalendarDatePicker(
                                initialDate: widget.initialDate,
                                firstDate: widget.firstDate,
                                lastDate: widget.lastDate,
                                onDateChanged: (date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                              ),
                            ),
                            Text(
                              "Selected event date",
                              style: kHeading6.copyWith(
                                color: fontColorPrimary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              margin: const EdgeInsets.only(
                                top: 10,
                                bottom: 24,
                              ),
                              decoration: BoxDecoration(
                                color: primarySecond,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                formattedDate,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PopupConfirmButton(
                                  width: 138,
                                  color: primarySecond,
                                  title: "Confirm",
                                  onTap: () {
                                    Navigator.pop(context, selectedDate);
                                  },
                                ),
                                gapW16,
                                PopupCancelButton(
                                  width: 92,
                                  color: darkGreyFirst,
                                  title: "Cancel",
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
