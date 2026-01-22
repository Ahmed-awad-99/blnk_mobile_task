import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/services/service_locator.dart';
import 'features/user_form/logic/user_form_provider.dart';
import 'features/user_form/presentation/screens/splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<UserFormProvider>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
