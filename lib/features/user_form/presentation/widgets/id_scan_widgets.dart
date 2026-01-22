import 'dart:io';

import 'package:flutter/material.dart';
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';

class IDScanWidgets {
  static Widget buildCameraPreview({
    required BuildContext context,
    required File? image,
    String placeholderText = 'Front ID will appear here',
  }) {
    return Container(
      width: ScreenUtils.pw(context, 380),
      height: ScreenUtils.ph(context, 300),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 12)),
        border: Border.all(
          color: const Color(0xFFE2E2EF),
          width: 1,
        ),
      ),
      child: image != null
          ? ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtils.pw(context, 12)),
        child: Image.file(
          image,
          fit: BoxFit.cover,
        ),
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            size: ScreenUtils.pw(context, 60),
            color: const Color(0xFF999999),
          ),
          SizedBox(height: ScreenUtils.ph(context, 20)),
          Text(
            placeholderText,
            style: TextStyle(
              fontFamily: 'Georama',
              fontSize: ScreenUtils.pw(context, 16),
              color: const Color(0xFF666666),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildScanButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    IconData icon = Icons.camera_alt,
    Color backgroundColor = const Color(0xFF338CD0),
  }) {
    return SizedBox(
      width: ScreenUtils.pw(context, 380),
      height: ScreenUtils.ph(context, 56),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF217FEB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ScreenUtils.pw(context, 30),
            ),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: ScreenUtils.pw(context, 14),
            fontWeight: FontWeight.w600,
            height: 1.0,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  static Widget buildNextButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required String text,
    Color backgroundColor = const Color(0xFF338CD0),
  }) {
    return SizedBox(
      width: ScreenUtils.pw(context, 380),
      height: ScreenUtils.ph(context, 56),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF217FEB),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ScreenUtils.pw(context, 30),
            ),
          ),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: ScreenUtils.pw(context, 14),
            fontWeight: FontWeight.w600,
            height: 1.0,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }

  static Widget buildInstructionText({
    required BuildContext context,
    required String titleLine1,
    String? titleLine2,
    required String subtitleLine1,
    String? subtitleLine2,
  }) {
    return Center(
      child: Column(
        children: [
          Text(
            titleLine1,
            style: TextStyle(
              fontFamily: 'Georama',
              fontSize: ScreenUtils.pw(context, 24),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
            ),
          ),
          if (titleLine2 != null) ...[
            SizedBox(height: ScreenUtils.ph(context, 10)),
            Text(
              titleLine2,
              style: TextStyle(
                fontFamily: 'Georama',
                fontSize: ScreenUtils.pw(context, 24),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF333333),
              ),
            ),
          ],
          SizedBox(height: ScreenUtils.ph(context, 20)),
          Text(
            subtitleLine1,
            style: TextStyle(
              fontFamily: 'Georama',
              fontSize: ScreenUtils.pw(context, 16),
              color: const Color(0xFF666666),
            ),
          ),
          if (subtitleLine2 != null) ...[
            SizedBox(height: ScreenUtils.ph(context, 5)),
            Text(
              subtitleLine2,
              style: TextStyle(
                fontFamily: 'Georama',
                fontSize: ScreenUtils.pw(context, 16),
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ],
      ),
    );
  }
}