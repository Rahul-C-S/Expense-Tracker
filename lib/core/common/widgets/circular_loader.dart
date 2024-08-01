import 'package:expense_tracker/core/theme/color_pallette.dart';
import 'package:flutter/material.dart';

class CircularLoader extends StatelessWidget {
  const CircularLoader({super.key});

  static void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Dialog(
          elevation: 0,
          backgroundColor: ColorPallette.transparent,
          child: Stack(
            children: [
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: ColorPallette.semiTransparent,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(50),
                  child: const CircularProgressIndicator(
                    color: ColorPallette.light,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
