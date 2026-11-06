import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() => runApp(const Lab10App());

class Lab10App extends StatelessWidget {
  const Lab10App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
    home: const LoginScreen(),
  );
}
