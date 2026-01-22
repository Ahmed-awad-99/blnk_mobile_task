import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';
import 'dart:io';

class ReviewWidgets {
  static Widget buildInfoSection({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    bool isMultiLine = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(
              icon,
              size: ScreenUtils.pw(context, 13),
              color: const Color(0xFF333333),
            ),
            SizedBox(width: ScreenUtils.pw(context, 8)),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Georama',
                fontSize: ScreenUtils.pw(context, 14),
                fontWeight: FontWeight.w500,
                color: const Color(0xFF777777),
              ),
            ),
          ],
        ),
        SizedBox(height: ScreenUtils.ph(context, 8)),
        Container(
          width: ScreenUtils.pw(context, 382),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.pw(context, 16),
            vertical: ScreenUtils.ph(context, 12),
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE2ECF7),
            borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 8)),
            border: Border.all(color: const Color(0xFFE2E2EF), width: 1),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'Georama',
              fontSize: ScreenUtils.pw(context, 16),
              color: const Color(0xFF333333),
              height: isMultiLine ? 1.5 : 1.2,
            ),
          ),
        ),
        SizedBox(height: ScreenUtils.ph(context, 20)),
      ],
    );
  }

  static Widget buildNationalIdField({
    required BuildContext context,
    required String label,
    required File? image,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: ScreenUtils.ph(context, 8)),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: ScreenUtils.pw(context, 382),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtils.pw(context, 16),
              vertical: ScreenUtils.ph(context, 12),
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFE2ECF7),
              borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 8)),
              border: Border.all(color: const Color(0xFFE2E2EF), width: 1),
            ),
            child: Row(
              children: [
                FaIcon(
                  FontAwesomeIcons.image,
                  size: ScreenUtils.pw(context, 20),
                  color: const Color(0xFF333333),
                ),
                SizedBox(width: ScreenUtils.pw(context, 12)),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Georama',
                    fontSize: ScreenUtils.pw(context, 14),
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF217FEB),
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFF217FEB),
                    decorationThickness: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: ScreenUtils.ph(context, 12)),
      ],
    );
  }

  static Widget buildSubmitButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required bool isLoading,
  }) {
    if (isLoading) {
      return SizedBox(
        width: ScreenUtils.pw(context, 380),
        height: ScreenUtils.ph(context, 56),
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF338CD0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 8)),
            ),
            elevation: 0,
          ),
          child: const CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    return Center(
      child: SizedBox(
        width: ScreenUtils.pw(context, 261),
        height: ScreenUtils.ph(context, 48),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF217FEB),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 30)),
            ),
            padding: EdgeInsets.zero,
            elevation: 0,
          ),
          child: Text(
            'Submit',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: ScreenUtils.pw(context, 14),
              fontWeight: FontWeight.w600,
              height: 1.0,
              letterSpacing: 0,
            ),
          ),
        ),
      ),
    );
  }
}