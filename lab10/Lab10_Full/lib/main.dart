import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'services/google_auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GoogleAuthService.initialize();
  runApp(const Lab10App());
}

class Lab10App extends StatelessWidget {
  const Lab10App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const SplashScreen(),
  );
}
