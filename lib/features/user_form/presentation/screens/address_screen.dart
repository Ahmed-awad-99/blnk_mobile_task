import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// Core
import 'package:blnk_mobile_task/core/utils/screen_utils.dart';
import 'package:blnk_mobile_task/core/utils/validators.dart';

// Widgets
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/step_widgets.dart';
import 'package:blnk_mobile_task/features/user_form/presentation/widgets/address_widgets.dart';

// Logic
import 'package:blnk_mobile_task/features/user_form/logic/user_form_provider.dart';

// Screens
import 'package:blnk_mobile_task/features/user_form/presentation/screens/id_scan_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();

  final _apartmentController = TextEditingController();
  final _floorController = TextEditingController();
  final _buildingController = TextEditingController();
  final _streetController = TextEditingController();
  final _areaController = TextEditingController();
  final _cityController = TextEditingController();
  final _landmarkController = TextEditingController();

  @override
  void dispose() {
    _apartmentController.dispose();
    _floorController.dispose();
    _buildingController.dispose();
    _streetController.dispose();
    _areaController.dispose();
    _cityController.dispose();
    _landmarkController.dispose();
    super.dispose();
  }

  void _saveDataAndNavigate(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<UserFormProvider>(context, listen: false);

      provider.setApartment(_apartmentController.text.trim());
      provider.setFloor(_floorController.text.trim());
      provider.setBuilding(_buildingController.text.trim());
      provider.setStreet(_streetController.text.trim());
      provider.setArea(_areaController.text.trim());
      provider.setCity(_cityController.text.trim());
      provider.setLandmark(_landmarkController.text.trim());

      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, animation, _) => const IDScanScreen(),
          transitionsBuilder: (_, animation, _, child) {
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ScreenUtils.ph(context, 30)),

                /// Stepper (Step 2)
                StepWidgets.buildStepsRow(context, 2),

                SizedBox(height: ScreenUtils.ph(context, 80)),

                /// Apartment - Floor - Building
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddressWidgets.buildSmallAddressField(
                      context: context,
                      label: 'Apartment',
                      controller: _apartmentController,
                      width: 120,
                      height: 59,
                      validator: (value) => Validators.validateRequired(value, 'Apartment'),
                    ),
                    AddressWidgets.buildSmallAddressField(
                      context: context,
                      label: 'Floor',
                      controller: _floorController,
                      width: 120,
                      height: 59,
                      keyboardType: TextInputType.number,
                      validator: (value) => Validators.validateRequired(value, 'Floor'),
                    ),
                    AddressWidgets.buildSmallAddressField(
                      context: context,
                      label: 'Building',
                      controller: _buildingController,
                      width: 120,
                      height: 59,
                      validator: (value) => Validators.validateRequired(value, 'Building'),
                    ),
                  ],
                ),

                SizedBox(height: ScreenUtils.ph(context, 20)),

                /// Street Name
                AddressWidgets.buildAddressTextField(
                  context: context,
                  label: 'Street Name',
                  controller: _streetController,
                  width: 380,
                  height: 59,
                  validator: (value) => Validators.validateRequired(value, 'Street Name'),
                ),

                SizedBox(height: ScreenUtils.ph(context, 20)),

                /// Area & City Row
                Row(
                  children: [
                    Expanded(
                      child: AddressWidgets.buildAddressTextField(
                        context: context,
                        label: 'Area',
                        controller: _areaController,
                        width: 185,
                        height: 59,
                        validator: (value) => Validators.validateRequired(value, 'Area'),
                      ),
                    ),
                    SizedBox(width: ScreenUtils.pw(context, 10)),
                    Expanded(
                      child: AddressWidgets.buildAddressTextField(
                        context: context,
                        label: 'City',
                        controller: _cityController,
                        width: 185,
                        height: 59,
                        validator: (value) => Validators.validateRequired(value, 'City'),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ScreenUtils.ph(context, 20)),

                /// Land Mark
                AddressWidgets.buildAddressTextField(
                  context: context,
                  label: 'Land Mark',
                  controller: _landmarkController,
                  width: 380,
                  height: 59,
                  validator: (value) => Validators.validateRequired(value, 'Land Mark'),
                ),

                SizedBox(height: ScreenUtils.ph(context, 210)),

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
    );
  }
}