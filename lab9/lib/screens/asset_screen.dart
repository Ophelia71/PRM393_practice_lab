import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/local_item.dart';
import '../services/json_storage.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});
  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  late final Future<List<LocalItem>> _future;

  @override
  void initState() {
    super.initState();
    _future = _readAsset();
  }

  Future<List<LocalItem>> _readAsset() async {
    // Asset nằm trong gói ứng dụng, chỉ đọc; không ghi thay đổi vào asset.
    final text = await rootBundle.loadString('assets/data/products.json');
    return decodeItems(text);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalItem>>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Không đọc được asset: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              leading: CircleAvatar(child: Text('${item.id}')),
              title: Text(item.name),
              subtitle: Text(item.note),
            );
          },
        );
      },
    );
  }
}
