import 'package:expense_tracker/core/common/widgets/circular_loader.dart';
import 'package:flutter/material.dart';

class Loader {

  static bool _status = false;

  static void circular(BuildContext context) {
    // Show circular indicator
    _status = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularLoader(),
      ),
    );
  }

  static void hide(BuildContext context) {
    // Hide loader

    if (Navigator.of(context).canPop() && _status) {
      Navigator.of(context).pop();
    }
    _status = false;
  }

// Returns the current state of loader
  static bool getStatus() => _status;
}