import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  final Color bgColor;
  final Color fontColor;
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.buttonText,
    this.bgColor = ColorPallette.primaryShade2,
    this.fontColor = ColorPallette.primaryShade3,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 50,
      // margin: EdgeInsets.symmetric(horizontal: 50),
      color: bgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: fontColor,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
