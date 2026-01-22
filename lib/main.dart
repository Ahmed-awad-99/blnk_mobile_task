import 'package:flutter/material.dart';
import 'app.dart';
import 'core/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServiceLocator.init();

  runApp(const App());
}