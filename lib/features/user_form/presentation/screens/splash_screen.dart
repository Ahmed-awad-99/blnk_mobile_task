import 'dart:async';
import 'package:flutter/material.dart';
import 'package:blnk_mobile_task/core/constants/app_constants.dart';
import 'package:blnk_mobile_task/features/user_form/presentation/screens/personal_info_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  double pw(BuildContext context, double width) =>
      (width / AppConstants.figmaWidth) *
          MediaQuery.of(context).size.width;

  double ph(BuildContext context, double height) =>
      (height / AppConstants.figmaHeight) *
          MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), _navigateNext);
  }

  void _navigateNext() {
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PersonalInfoScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: Stack(
        children: [
          Positioned(
            top: ph(context, 231),
            left: pw(context, 40),
            child: Image.asset(
              'assets/images/logo.png',
              width: pw(context, 349),
              height: pw(context, 349),
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            top: ph(context, 780),
            left: pw(context, 152),
            child: Text(
              'Company Name ©️ 2024',
              style: TextStyle(
                fontSize: pw(context, 13),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF474443),
              ),
            ),
          ),
        ],
      ),
    );
  }
}