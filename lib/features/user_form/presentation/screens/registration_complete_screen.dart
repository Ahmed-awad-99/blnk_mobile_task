import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationCompleteScreen extends StatelessWidget {
  const RegistrationCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              Container(
                width: 115,
                height: 115,
                decoration: BoxDecoration(
                  color: const Color(0xFF3BAF85),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),

              const SizedBox(height: 49),

              Text(
                'Registration Complete',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Georama',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF333333),
                  height: 1.0,
                ),
              ),

              const SizedBox(height: 35),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 380,
                    minHeight: 69,
                  ),
                  child: Text(
                    'Congratulations! You have successfully completed the registration process. Your profile is now set up, and now you can start exploring all features and benefits we offer',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Georama',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF777777),
                      height: 1.8,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              Center(
                child: Container(
                  width: 261,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        offset: Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF217FEB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.zero,
                      elevation: 0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 54.55),
                      child: Text(
                        'Register Another User',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.0,
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}