import 'package:blnk_mobile_task/core/services/google_services.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserFormProvider extends ChangeNotifier {
  final GoogleService googleService;
  final String spreadsheetId;
  final String driveFolderId;

  UserFormProvider({
    required this.googleService,
    required this.spreadsheetId,
    required this.driveFolderId,
  });

  // Personal Info
  String firstName = '';
  String lastName = '';
  String landline = '';
  String mobile = '';
  String email = '';
  String nationalId = '';

  // Address Info
  String apartment = '';
  String floor = '';
  String building = '';
  String street = '';
  String area = '';
  String city = '';
  String landmark = '';

  // ID Images
  File? frontImage;
  File? backImage;

  // Uploaded File IDs
  String? frontImageDriveId;
  String? backImageDriveId;

  // Loading state
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  // Personal Info Setters
  void setFirstName(String value) {
    firstName = value;
    notifyListeners();
  }

  void setLastName(String value) {
    lastName = value;
    notifyListeners();
  }

  void setLandline(String value) {
    landline = value;
    notifyListeners();
  }

  void setMobile(String value) {
    mobile = value;
    notifyListeners();
  }

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setNationalId(String value) {
    nationalId = value;
    notifyListeners();
  }

  // Address Setters
  void setApartment(String value) {
    apartment = value;
    notifyListeners();
  }

  void setFloor(String value) {
    floor = value;
    notifyListeners();
  }

  void setBuilding(String value) {
    building = value;
    notifyListeners();
  }

  void setStreet(String value) {
    street = value;
    notifyListeners();
  }

  void setArea(String value) {
    area = value;
    notifyListeners();
  }

  void setCity(String value) {
    city = value;
    notifyListeners();
  }

  void setLandmark(String value) {
    landmark = value;
    notifyListeners();
  }

  // Pick images
  Future<void> pickFrontImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 90,
    );
    if (image != null) {
      frontImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> pickBackImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 90,
    );
    if (image != null) {
      backImage = File(image.path);
      notifyListeners();
    }
  }

  // Helper methods for review screen
  String get fullName => '$firstName $lastName'.trim();

  String get phoneNumbers {
    final phones = <String>[];
    if (mobile.isNotEmpty) phones.add(mobile);
    return phones.join('\n');
  }

  String get formattedNationalId {
    if (nationalId.isEmpty) return '';
    if (nationalId.length != 14) return nationalId;

    return '${nationalId.substring(0, 2)}-${nationalId.substring(2, 6)}-${nationalId.substring(6, 10)}-${nationalId.substring(10, 14)}';
  }

  String get homeAddress {
    final addressParts = <String>[];
    if (building.isNotEmpty) addressParts.add(building);
    if (street.isNotEmpty) addressParts.add(street);
    if (area.isNotEmpty) addressParts.add(area);
    if (city.isNotEmpty) addressParts.add(city);

    final fullAddress = addressParts.join(', ');
    final apartmentInfo = 'Floor $floor Apartment $apartment';

    return '$fullAddress\n$apartmentInfo';
  }

  // Validation
  bool validatePersonalInfo() {
    return firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        mobile.isNotEmpty ;
  }

  bool validateAddress() {
    return apartment.isNotEmpty &&
        floor.isNotEmpty &&
        building.isNotEmpty &&
        street.isNotEmpty &&
        area.isNotEmpty &&
        city.isNotEmpty;
  }

  bool validateIdImages() {
    return frontImage != null && backImage != null;
  }

  // Loading state
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Reset form
  void resetForm() {
    firstName = '';
    lastName = '';
    landline = '';
    mobile = '';
    email = '';
    nationalId = '';

    apartment = '';
    floor = '';
    building = '';
    street = '';
    area = '';
    city = '';
    landmark = '';

    frontImage = null;
    backImage = null;
    frontImageDriveId = null;
    backImageDriveId = null;

    isLoading = false;
    notifyListeners();
  }

  Future<void> submitForm() async {
    if (!validatePersonalInfo()) {
      final missing = <String>[];
      if (firstName.isEmpty) missing.add('First Name');
      if (lastName.isEmpty) missing.add('Last Name');
      if (mobile.isEmpty) missing.add('Mobile Number');

      throw Exception('Please fill: ${missing.join(", ")}');
    }

    if (!validateAddress()) {
      throw Exception('Please fill all address fields');
    }

    if (!validateIdImages()) {
      throw Exception('Please scan both ID images');
    }

    try {
      setLoading(true);

      frontImageDriveId = await googleService.uploadFileToDrive(
        file: frontImage!,
        folderId: driveFolderId,
        customFileName: '${nationalId}_front_id.jpg',
      );

      backImageDriveId = await googleService.uploadFileToDrive(
        file: backImage!,
        folderId: driveFolderId,
        customFileName: '${nationalId}_back_id.jpg',
      );

      final detailedAddress = '$building $street, $area, $city';

      await googleService.addUserToSheet(
        spreadsheetId: spreadsheetId,
        rowData: [
          firstName,
          lastName,
          detailedAddress,
          landline.isNotEmpty ? landline : 'N/A',
          mobile,
          nationalId.isNotEmpty ? nationalId : 'EXTRACTING...',
          frontImageDriveId ?? 'N/A',
          backImageDriveId ?? 'N/A',
        ],
      );

      resetForm();
    } catch (e) {
      throw Exception('Failed to submit form: $e');
    } finally {
      setLoading(false);
    }
  }
}