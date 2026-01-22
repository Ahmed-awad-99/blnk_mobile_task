import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';

class GoogleService {
  static const _scopes = [
    sheets.SheetsApi.spreadsheetsScope,
    drive.DriveApi.driveScope,
  ];

  final String credentialsPath;
  sheets.SheetsApi? _sheetsApi;
  drive.DriveApi? _driveApi;

  GoogleService({required this.credentialsPath});

  Future<void> init() async {
    final credentialsJson = await rootBundle.loadString(credentialsPath);

    final accountCredentials =
    ServiceAccountCredentials.fromJson(credentialsJson);

    final client = await clientViaServiceAccount(accountCredentials, _scopes);

    _sheetsApi = sheets.SheetsApi(client);
    _driveApi = drive.DriveApi(client);
  }

  sheets.SheetsApi get sheetsApi => _sheetsApi!;
  drive.DriveApi get driveApi => _driveApi!;

  Future<void> addUserToSheet({
    required String spreadsheetId,
    required List<String> rowData,
  }) async {
    if (_sheetsApi == null) {
      throw Exception('Sheets API not initialized. Call init() first.');
    }

    final valueRange = sheets.ValueRange.fromJson({
      'values': [rowData]
    });

    await sheetsApi.spreadsheets.values.append(
      valueRange,
      spreadsheetId,
      'Sheet1!A1',
      valueInputOption: 'RAW',
    );
  }

  Future<String> uploadFileToDrive({
    required File file,
    required String folderId,
    String? customFileName,
  }) async {
    if (_driveApi == null) {
      throw Exception('Drive API not initialized. Call init() first.');
    }

    final fileName = customFileName ??
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';

    var driveFile = drive.File();
    driveFile.name = fileName;
    driveFile.parents = [folderId];

    final media = drive.Media(file.openRead(), await file.length());

    final uploadedFile = await driveApi.files.create(
      driveFile,
      uploadMedia: media,
      supportsAllDrives: true,
    );

    return uploadedFile.id!;
  }

  Future<void> initializeSheet({
    required String spreadsheetId,
    required String sheetName,
  }) async {
    if (_sheetsApi == null) {
      throw Exception('Sheets API not initialized. Call init() first.');
    }

    try {
      // Check if sheet has headers
      final response = await sheetsApi.spreadsheets.values.get(
        spreadsheetId,
        '$sheetName!A1:I1',
      );

      if (response.values == null || response.values!.isEmpty) {
        // Add headers - 9 columns
        final headers = [
          'First Name',        // A
          'Last Name',         // B
          'Detailed Address',  // C
          'Landmark',          // D
          'Landline',          // E
          'Mobile',            // F
          'National ID',       // G
          'Front ID File ID',  // H
          'Back ID File ID',   // I
        ];

        final headerRange = sheets.ValueRange.fromJson({
          'values': [headers]
        });

        await sheetsApi.spreadsheets.values.update(
          headerRange,
          spreadsheetId,
          '$sheetName!A1:I1',
          valueInputOption: 'USER_ENTERED',
        );
      } else {
        return;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> testConnection() async {
    try {
      if (_sheetsApi == null || _driveApi == null) {
        return false;
      }

      await _sheetsApi!.spreadsheets.get('test');
      return true;
    } catch (e) {
      return true;
    }
  }
}