import 'package:flutter/material.dart';

import 'screens/asset_screen.dart';
import 'screens/storage_screen.dart';

void main() => runApp(const Lab9App());

class Lab9App extends StatelessWidget {
  const Lab9App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Lab 9 - Local JSON'),
            bottom: const TabBar(
              tabs: [
                Tab(text: '9.1 Asset'),
                Tab(text: '9.2 Lưu file'),
                Tab(text: '9.3 CRUD'),
              ],
            ),
          ),
          body: const SafeArea(
            child: TabBarView(
              children: [
                AssetScreen(),
                StorageScreen(autoSave: false),
                StorageScreen(autoSave: true),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
