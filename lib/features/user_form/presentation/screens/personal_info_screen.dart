import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Core
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';
import 'package:blnk_mobile_task/core/utils/validators.dart';

// Widgets
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/step_widgets.dart';
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/custom_text_field.dart';

// Logic
import 'package:blnk_mobile_task/features/user_form/logic/user_form_provider.dart';

// Screens
import 'package:blnk_mobile_task/features/user_form/presentation/screens/address_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _landlineController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _landlineController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveDataAndNavigate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<UserFormProvider>(context, listen: false);

      provider.setFirstName(_firstNameController.text.trim());
      provider.setLastName(_lastNameController.text.trim());
      provider.setMobile(_mobileController.text.trim());
      provider.setLandline(_landlineController.text.trim());
      provider.setEmail(_emailController.text.trim());

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, animation, __) => const AddressScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.easeOut),
                ),
              ),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtils.pw(context, 25),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: ScreenUtils.ph(context, 30)),

                  /// Title
                  Center(
                    child: SizedBox(
                      height: ScreenUtils.ph(context, 29),
                      child: Text(
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
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 40)),

                  /// Steps
                  StepWidgets.buildStepsRow(context, 1),

                  SizedBox(height: ScreenUtils.ph(context, 40)),

                  /// Welcome text
                  SizedBox(
                    width: ScreenUtils.pw(context, 380),
                    child: Text(
                      'Welcome! Let\'s get started by gathering some basic information about you. Please fill out the following fields',
                      style: TextStyle(
                        fontFamily: 'Georama',
                        fontSize: ScreenUtils.pw(context, 13),
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF777777),
                        height: 1.8,
                        letterSpacing: 0,
                      ),
                    ),
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 40)),

                  /// Fields
                  CustomTextField(
                    context: context,
                    label: 'First Name',
                    controller: _firstNameController,
                    validator: (value) => Validators.validateRequired(value, 'First Name'),
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 20)),

                  CustomTextField(
                    context: context,
                    label: 'Last Name',
                    controller: _lastNameController,
                    validator: (value) => Validators.validateRequired(value, 'Last Name'),
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 20)),

                  CustomTextField(
                    context: context,
                    label: 'Mobile Number',
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => Validators.validatePhone(value, 'Mobile Number'),
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 20)),

                  CustomTextField(
                    context: context,
                    label: 'Landline',
                    controller: _landlineController,
                    keyboardType: TextInputType.phone,
                    validator: (value) => Validators.validatePhone(value, 'Landline'),
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 20)),

                  CustomTextField(
                    context: context,
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 100)),

                  /// Next Button
                  Center(
                    child: SizedBox(
                      width: ScreenUtils.pw(context, 261),
                      height: ScreenUtils.ph(context, 48),
                      child: ElevatedButton(
                        onPressed: () => _saveDataAndNavigate(context),
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
                          'Next',
                          textAlign: TextAlign.center,
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
                  ),

                  SizedBox(height: ScreenUtils.ph(context, 40)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}