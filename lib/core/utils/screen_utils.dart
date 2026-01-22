import 'package:flutter/material.dart';

class ScreenUtils {
  static const double figmaWidth = 430;
  static const double figmaHeight = 932;

  static double responsiveWidth(BuildContext context, double width) {
    return (width / figmaWidth) * MediaQuery.of(context).size.width;
  }

  static double responsiveHeight(BuildContext context, double height) {
    return (height / figmaHeight) * MediaQuery.of(context).size.height;
  }

  // Shortcuts
  static double pw(BuildContext context, double width) => responsiveWidth(context, width);
  static double ph(BuildContext context, double height) => responsiveHeight(context, height);
}