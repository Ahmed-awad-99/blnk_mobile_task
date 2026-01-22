import 'package:flutter/material.dart';
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';

class AddressWidgets {
  static OutlineInputBorder _border(BuildContext context, Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 6)),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  static Widget buildAddressTextField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    double width = 380,
    double height = 59,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: ScreenUtils.pw(context, width),
      height: ScreenUtils.ph(context, height),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          fontFamily: 'Georama',
          fontSize: ScreenUtils.pw(context, 16),
          color: const Color(0xFF333333),
        ),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            fontFamily: 'Georama',
            fontSize: ScreenUtils.pw(context, 12),
            fontWeight: FontWeight.w500,
            color: const Color(0xFF444444),
            height: 1.0,
            letterSpacing: 0,
          ),
          enabledBorder: _border(context, const Color(0xFFE2E2EF), 1),
          focusedBorder: _border(context, const Color(0xFF338CD0), 2),
          errorBorder: _border(context, Colors.red, 1),
          focusedErrorBorder: _border(context, Colors.red, 2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.pw(context, 16),
            vertical: ScreenUtils.ph(context, 14),
          ),
        ),
      ),
    );
  }

  static Widget buildSmallAddressField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required double width,
    double height = 59,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: ScreenUtils.pw(context, width),
      height: ScreenUtils.ph(context, height),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          fontFamily: 'Georama',
          fontSize: ScreenUtils.pw(context, 16),
          color: const Color(0xFF333333),
        ),
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(
            fontFamily: 'Georama',
            fontSize: ScreenUtils.pw(context, 12),
            color: const Color(0xFF444444),
          ),
          enabledBorder: _border(context, const Color(0xFFE2E2EF), 1),
          focusedBorder: _border(context, const Color(0xFF338CD0), 2),
          errorBorder: _border(context, Colors.red, 1),
          focusedErrorBorder: _border(context, Colors.red, 2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.pw(context, 12),
            vertical: ScreenUtils.ph(context, 14),
          ),
        ),
      ),
    );
  }
}