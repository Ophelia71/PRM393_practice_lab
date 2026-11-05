import 'package:flutter/material.dart';

import '../models/local_item.dart';

// Dialog tự quản lý controller theo vòng đời widget, không cần canh thời gian đóng.
class ItemEditorDialog extends StatefulWidget {
  final int id;
  final LocalItem? item;
  const ItemEditorDialog({super.key, required this.id, this.item});
  @override
  State<ItemEditorDialog> createState() => _ItemEditorDialogState();
}

class _ItemEditorDialogState extends State<ItemEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _note;
  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.item?.name ?? '');
    _note = TextEditingController(text: widget.item?.note ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _note.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      LocalItem(
        id: widget.id,
        name: _name.text.trim(),
        note: _note.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
    title: Text(widget.item == null ? 'Thêm mục mới' : 'Sửa mục'),
    content: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              key: const ValueKey('itemName'),
              controller: _name,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Tên'),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Hãy nhập tên' : null,
            ),
            TextFormField(
              key: const ValueKey('itemNote'),
              controller: _note,
              decoration: const InputDecoration(labelText: 'Ghi chú'),
            ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Hủy'),
      ),
      FilledButton(onPressed: _submit, child: const Text('Xong')),
    ],
  );
}
