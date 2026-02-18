import 'package:flutter/material.dart';
import 'package:labamu/core/utils/constants.dart';
import 'package:labamu/core/widgets/popup_cancel_button.dart';
import 'package:labamu/core/widgets/popup_confirm_button.dart';

class DefaultTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;
  const DefaultTimePicker({super.key, required this.initialTime});

  @override
  State<DefaultTimePicker> createState() => _DefaultTimePickerState();
}

class _DefaultTimePickerState extends State<DefaultTimePicker> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = widget.initialTime;
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
                  String formattedTime = selectedTime.format(context);
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
                              "Select Time",
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
                                colorScheme: const ColorScheme.light(
                                  primary: primarySecond,
                                ),
                                buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary,
                                ),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  TimeOfDay? pickedTime = await showTimePicker(
                                    context: context,
                                    initialTime: selectedTime,
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          timePickerTheme: TimePickerThemeData(
                                            backgroundColor: Colors
                                                .white, // Background color
                                            hourMinuteTextColor:
                                                WidgetStateColor.resolveWith(
                                                  (states) =>
                                                      primarySecond, // Change text color
                                                ),
                                            dialHandColor:
                                                primarySecond, // Dial hand color
                                            dialTextColor:
                                                WidgetStateColor.resolveWith(
                                                  (states) => Colors
                                                      .black, // Dial numbers color
                                                ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedTime != null &&
                                      pickedTime != selectedTime) {
                                    setState(() {
                                      selectedTime = pickedTime;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primarySecond,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                                child: Text(
                                  "Pick Time",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Selected Event Time",
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
                                formattedTime,
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
                                    Navigator.pop(context, selectedTime);
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
