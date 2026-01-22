import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';

class CustomTextField extends StatelessWidget {
  final BuildContext context;
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.context,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength,
    this.inputFormatters,
  });

  OutlineInputBorder _border(Color color, double width) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 6)),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtils.pw(context, 380),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
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
          counterText: '',
          enabledBorder: _border(const Color(0xFFE2E2EF), 1),
          focusedBorder: _border(const Color(0xFF338CD0), 2),
          errorBorder: _border(Colors.red, 1),
          focusedErrorBorder: _border(Colors.red, 2),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.pw(context, 16),
            vertical: ScreenUtils.ph(context, 14),
          ),
        ),
      ),
    );
  }
}