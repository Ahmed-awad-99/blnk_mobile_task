import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Core
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';

// Widgets
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/step_widgets.dart';
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/review_widgets.dart';

// Logic
import 'package:blnk_mobile_task/features/user_form/logic/user_form_provider.dart';

// Screens
import 'package:blnk_mobile_task/features/user_form/presentation/screens/full_screen_image_page.dart';
import 'package:blnk_mobile_task/features/user_form/presentation/screens/registration_complete_screen.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  Future<void> _submitData(BuildContext context) async {
    final provider = Provider.of<UserFormProvider>(context, listen: false);

    try {
      await provider.submitForm();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const RegistrationCompleteScreen(),
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to submit data. Please try again.\nError: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserFormProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFF444444),
              size: 16,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          title: Text(
            'Create Account',
            style: TextStyle(
              fontFamily: 'Georama',
              fontSize: ScreenUtils.pw(context, 24),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF333333),
              height: 1.0,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtils.pw(context, 25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ScreenUtils.ph(context, 30)),

              /// Stepper (All completed)
              StepWidgets.buildStepsRow(context, 3),

              SizedBox(height: ScreenUtils.ph(context, 40)),

              /// Full Name Section
              ReviewWidgets.buildInfoSection(
                context: context,
                title: 'FULL NAME',
                value: provider.fullName.isEmpty ? 'Not provided' : provider.fullName,
                icon: FontAwesomeIcons.user,
              ),

              /// Phone Numbers Section
              ReviewWidgets.buildInfoSection(
                context: context,
                title: 'PHONE NUMBERS',
                value: provider.phoneNumbers.isEmpty ? 'Not provided' : provider.phoneNumbers,
                icon: FontAwesomeIcons.mobileScreen,
                isMultiLine: true,
              ),

              /// Email Address Section
              ReviewWidgets.buildInfoSection(
                context: context,
                title: 'EMAIL ADDRESS',
                value: provider.email.isEmpty ? 'Not provided' : provider.email,
                icon: FontAwesomeIcons.at,
              ),

              /// Home Address Section
              ReviewWidgets.buildInfoSection(
                context: context,
                title: 'HOME ADDRESS',
                value: provider.homeAddress.isEmpty ? 'Not provided' : provider.homeAddress,
                icon: FontAwesomeIcons.locationDot,
                isMultiLine: true,
              ),

              /// NATIONAL ID Section
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.idCard,
                    size: ScreenUtils.pw(context, 13),
                    color: const Color(0xFF333333),
                  ),
                  SizedBox(width: ScreenUtils.pw(context, 8)),
                  Text(
                    'NATIONAL ID',
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

              /// Front ID Field
              ReviewWidgets.buildNationalIdField(
                context: context,
                label: 'Front Id',
                image: provider.frontImage,
                onTap: () {
                  if (provider.frontImage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagePage(
                          image: provider.frontImage!,
                          title: 'Front Id',
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No Front Id image available'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),

              /// Back ID Field
              ReviewWidgets.buildNationalIdField(
                context: context,
                label: 'Back Id',
                image: provider.backImage,
                onTap: () {
                  if (provider.backImage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagePage(
                          image: provider.backImage!,
                          title: 'Back Id',
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No Back Id image available'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: ScreenUtils.ph(context, 30)),

              /// Submit Button
              SizedBox(
                width: ScreenUtils.pw(context, 380),
                height: ScreenUtils.ph(context, 56),
                child: Consumer<UserFormProvider>(
                  builder: (context, provider, child) {
                    return ReviewWidgets.buildSubmitButton(
                      context: context,
                      onPressed: () => _submitData(context),
                      isLoading: provider.isLoading,
                    );
                  },
                ),
              ),

              SizedBox(height: ScreenUtils.ph(context, 40)),
            ],
          ),
        ),
      ),
    );
  }
}