import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Core
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';
import 'package:blnk_mobile_task/core/utils/navigation_utils.dart';

// Widgets
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/step_widgets.dart';
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/id_scan_widgets.dart';

// Logic
import 'package:blnk_mobile_task/features/user_form/logic/user_form_provider.dart';

// Screens
import 'package:blnk_mobile_task/features/user_form/presentation/screens/id_back_scan_screen.dart';

class IDScanScreen extends StatelessWidget {
  const IDScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

              /// Stepper
              StepWidgets.buildStepsRow(context, 3),

              SizedBox(height: ScreenUtils.ph(context, 8)),

              Center(
                child: Text(
                  'step 3 (scanning & cropping front id side)',
                  style: TextStyle(
                    fontFamily: 'Georama',
                    fontSize: ScreenUtils.pw(context, 14),
                    color: const Color(0xFF666666),
                  ),
                ),
              ),

              SizedBox(height: ScreenUtils.ph(context, 40)),

              /// Instruction Text
              IDScanWidgets.buildInstructionText(
                context: context,
                titleLine1: 'Scanning & crop',
                titleLine2: 'front Id side',
                subtitleLine1: 'using YOUR OWN',
                subtitleLine2: 'camera ui',
              ),

              SizedBox(height: ScreenUtils.ph(context, 60)),

              /// Camera Preview
              Consumer<UserFormProvider>(
                builder: (context, provider, child) {
                  return IDScanWidgets.buildCameraPreview(
                    context: context,
                    image: provider.frontImage,
                    placeholderText: 'Front ID will appear here',
                  );
                },
              ),

              SizedBox(height: ScreenUtils.ph(context, 30)),

              /// Scan Button
              IDScanWidgets.buildScanButton(
                context: context,
                onPressed: () async {
                  final provider = Provider.of<UserFormProvider>(
                    context,
                    listen: false,
                  );
                  await provider.pickFrontImage();
                },
                text: 'Scan Front ID',
                icon: Icons.camera_alt,
              ),

              SizedBox(height: ScreenUtils.ph(context, 20)),

              /// Next Button
              Consumer<UserFormProvider>(
                builder: (context, provider, child) {
                  return IDScanWidgets.buildNextButton(
                    context: context,
                    onPressed: () {
                      if (provider.frontImage != null) {
                        Navigator.push(
                          context,
                          NavigationUtils.slideTransitionRoute(
                            page: const IDBackScanScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please scan front ID first'),
                          ),
                        );
                      }
                    },
                    text: 'Next',
                  );
                },
              ),

              SizedBox(height: ScreenUtils.ph(context, 40)),
            ],
          ),
        ),
      ),
    );
  }
}