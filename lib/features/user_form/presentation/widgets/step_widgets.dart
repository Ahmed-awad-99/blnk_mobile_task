import 'package:flutter/material.dart';
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';

class StepWidgets {
  static Widget stepCircle({
    required BuildContext context,
    required String text,
    required bool active,
  }) {
    return Container(
      width: ScreenUtils.pw(context, 30),
      height: ScreenUtils.pw(context, 30),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF338CD0) : Colors.white,
        shape: BoxShape.circle,
        border: active
            ? null
            : Border.all(color: const Color(0xFFD2D2D2), width: 2),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Georama',
            fontSize: ScreenUtils.pw(context, 14),
            color: active ? Colors.white : const Color(0xFFD2D2D2),
          ),
        ),
      ),
    );
  }

  static Widget stepLine(BuildContext context) {
    return Container(
      width: ScreenUtils.pw(context, 87),
      height: 2,
      color: const Color(0xFFD2D2D2),
    );
  }

  static Widget buildStepsRow(BuildContext context, int activeStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        stepCircle(context: context, text: '1', active: activeStep >= 1),
        stepLine(context),
        stepCircle(context: context, text: '2', active: activeStep >= 2),
        stepLine(context),
        stepCircle(context: context, text: '3', active: activeStep >= 3),
      ],
    );
  }
}