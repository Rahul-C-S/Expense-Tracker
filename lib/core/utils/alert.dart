import 'package:flutter/material.dart';

class Alert {
  static Future<void> showAlertDialog(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmButtonText,
    VoidCallback? onConfirm,
    String? cancelButtonText,
    VoidCallback? onCancel,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button to dismiss
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(message),
              ],
            ),
          ),
          actions: [
            if (cancelButtonText != null)
              TextButton(
                child: Text(cancelButtonText),
                onPressed: () {
                  if (onCancel != null) {
                    onCancel();
                  }
                  Navigator.of(context).pop();
                },
              ),
            TextButton(
              child: Text(confirmButtonText ?? 'Ok'),
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
