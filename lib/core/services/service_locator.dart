import 'package:get_it/get_it.dart';
import 'package:blnk_mobile_task/core/services/google_services.dart';
import 'package:blnk_mobile_task/features/user_form/logic/user_form_provider.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    // Google Service
    final googleService = GoogleService(
      credentialsPath: 'assets/credentials/blnk-flutter-task-dffb9ce09672.json',
    );
    await googleService.init();

    getIt.registerSingleton<GoogleService>(googleService);

    // UserFormProvider
    getIt.registerFactory<UserFormProvider>(() => UserFormProvider(
      googleService: getIt<GoogleService>(),
      spreadsheetId: '1ZpDcxnOLxbg0EqvviIpo9wwSVmyrc2P9BeVUYrjyPnI',
      driveFolderId: '1KXsqpaBOPDXvzgLaUrhfTdPRdWBdwhnW',
    ));
  }
}
