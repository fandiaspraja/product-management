import 'package:flutter/material.dart';
import 'package:labamu/core/utils/constants.dart';

class CustomToast {
  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = green,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
  }) {
    Future.delayed(Duration.zero, () {
      OverlayState? overlayState = Overlay.of(
        context,
      ); // Handle case where Overlay is not available
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Positioned(
          top: 50.0, // Adjust as needed
          left: 20.0, // Adjust as needed
          right: 20.0, // Adjust as needed
          child: Material(
            // Important: Prevents clipping of rounded corners
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(message, style: TextStyle(color: textColor)),
            ),
          ),
        ),
      );

      overlayState.insert(overlayEntry);

      Future.delayed(duration).then((_) {
        overlayEntry.remove();
      });
    });
  }

  static void showError(BuildContext context, String message) {
    show(context, message, backgroundColor: Colors.red);
  }
}
