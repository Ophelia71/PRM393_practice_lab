import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/local_item.dart';
import '../services/json_storage.dart';
import '../widgets/item_editor_dialog.dart';

class StorageScreen extends StatefulWidget {
  final bool autoSave;
  const StorageScreen({super.key, required this.autoSave});
  @override
  State<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends State<StorageScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final JsonStorage _storage;
  List<LocalItem> _items = [];
  bool _busy = true;
  bool _dirty = false;
  String? _error;
  String _query = '';
  String _filePath = '';

  @override
  void initState() {
    super.initState();
    // Hai bài dùng hai file khác nhau để dễ kiểm tra.
    _storage = JsonStorage(widget.autoSave ? 'database.json' : 'notes.json');
    if (!kIsWeb) _load();
  }

  Future<void> _load() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final items = await _storage.load();
      final file = await _storage.getFile();
      if (!mounted) return;
      setState(() {
        _items = items;
        _filePath = file.path;
        _dirty = false;
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _error = 'Không đọc được file. Kiểm tra file JSON rồi bấm tải lại. Dữ liệu cũ không bị ghi đè.';
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
        });
      }
    }
  }

  Future<void> _save() async {
    setState(() {
      _busy = true;
    });
    try {
      await _storage.save(_items);
      if (!mounted) return;
      setState(() {
        _dirty = false;
      });
      _message('Đã lưu file JSON.');
    } catch (_) {
      if (mounted) {
        _message(
          'Chưa lưu được. Dữ liệu trên màn hình vẫn còn, hãy thử lưu lại.',
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _busy = false;
        });
      }
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _edit([LocalItem? oldItem]) async {
    // ID mới lớn hơn ID lớn nhất đang có, không dùng độ dài List.
    var nextId = 1;
    for (final item in _items) {
      if (item.id >= nextId) nextId = item.id + 1;
    }
    final result = await showDialog<LocalItem>(
      context: context,
      builder: (_) =>
          ItemEditorDialog(id: oldItem?.id ?? nextId, item: oldItem),
    );
    if (result == null || !mounted) return;
    setState(() {
      if (oldItem == null) {
        _items.add(result);
      } else {
        final index = _items.indexWhere((item) => item.id == oldItem.id);
        _items[index] = result;
      }
      _dirty = true;
    });
    if (widget.autoSave) await _save();
  }

  Future<void> _delete(LocalItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xóa mục này?'),
        content: Text(item.name),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() {
      _items.removeWhere((row) => row.id == item.id);
      _dirty = true;
    });
    await _save();
  }

  @override
  Widget build(BuildContext context) {
    // Giữ danh sách chưa lưu khi người dùng chuyển qua lại giữa các tab.
    super.build(context);
    // File/path_provider là bài lưu trên thiết bị; Chrome chỉ xem được tab asset.
    if (kIsWeb) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Hãy chọn Android để thực hành đọc/ghi file JSON. Chrome vẫn xem được bài 9.1.',
          ),
        ),
      );
    }
    if (_busy) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(padding: const EdgeInsets.all(24), child: Text(_error!)),
            FilledButton(onPressed: _load, child: const Text('Tải lại')),
          ],
        ),
      );
    }
    final visible = _items
        .where(
          (item) => '${item.name} ${item.note}'.toLowerCase().contains(
            _query.toLowerCase(),
          ),
        )
        .toList();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                if (widget.autoSave)
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Tìm theo tên hoặc ghi chú',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => setState(() {
                      _query = value;
                    }),
                  ),
                Text(
                  _dirty
                      ? 'Có thay đổi chưa lưu'
                      : 'Dữ liệu đã lưu trên thiết bị',
                ),
                Wrap(
                  spacing: 8,
                  children: [
                    FilledButton.icon(
                      onPressed: _dirty ? _save : null,
                      icon: const Icon(Icons.save_outlined),
                      label: const Text('Lưu JSON'),
                    ),
                    OutlinedButton(
                      onPressed: _dirty ? null : _load,
                      child: const Text('Đọc lại file'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: visible.isEmpty
                ? const Center(
                    child: Text('Chưa có dữ liệu phù hợp. Bấm + để thêm.'),
                  )
                : ListView.builder(
                    itemCount: visible.length,
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      return ListTile(
                        key: ValueKey(item.id),
                        title: Text(item.name),
                        subtitle: Text('#${item.id} · ${item.note}'),
                        onTap: widget.autoSave ? () => _edit(item) : null,
                        trailing: widget.autoSave
                            ? IconButton(
                                tooltip: 'Xóa',
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () => _delete(item),
                              )
                            : null,
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 80),
            child: SelectableText(
              'File: $_filePath',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _edit,
        tooltip: 'Thêm mục',
        child: const Icon(Icons.add),
      ),
    );
  }
}
