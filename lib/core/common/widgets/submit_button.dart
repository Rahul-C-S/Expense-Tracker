import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';


class SubmitButton extends StatelessWidget {
  final VoidCallback onTap;
  final String buttonText;
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: 50,
      // margin: EdgeInsets.symmetric(horizontal: 50),
      color: ColorPallette.primaryShade2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      child: Center(
        child: Text(
          buttonText,
          style: const TextStyle(
            color: ColorPallette.light,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
