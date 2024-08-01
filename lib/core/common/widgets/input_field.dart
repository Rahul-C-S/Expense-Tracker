import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final bool required;
  final TextInputType? keyboard;

  final Color fillColor;
  final Color borderColor;
  final Color textColor;

  static final RegExp _phoneNumberRegExp = RegExp(r'^(\+91)?[6-9]\d{9}$');
  static bool validatePhone(String phoneNumber) {
    return _phoneNumberRegExp.hasMatch(phoneNumber);
  }

  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isObscureText = false,
    this.fillColor = ColorPallette.light,
    this.borderColor = ColorPallette.light,
    this.textColor = ColorPallette.dark,
    this.required = true,
    this.keyboard,
  });

  OutlineInputBorder _border() => OutlineInputBorder(
        borderSide: BorderSide(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(2),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: textColor,
      ),
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        labelText: hintText,
        labelStyle: TextStyle(
          color: textColor,
        ),
        hintStyle: TextStyle(
          color: textColor,
        ),
        floatingLabelStyle: TextStyle(
          color: textColor,
          backgroundColor: ColorPallette.primaryShade3,
          fontSize: 20,        
        ),
        fillColor: fillColor,
        filled: true,
        focusedBorder: _border(),
        border: _border(),
        enabledBorder: _border(),
        errorStyle: const TextStyle(
          color: ColorPallette.danger,
          fontSize: 14,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: ColorPallette.danger,
          ),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      validator: (value) {
        if (required) {
          if (value!.isEmpty) {
            return '$hintText is required';
          }
          if (keyboard == TextInputType.phone) {
            if(!validatePhone(value)){
              return 'Invalid phone';
            }
          }
        }

        return null;
      },
      obscureText: isObscureText,
      keyboardType: keyboard,
    );
  }
}
