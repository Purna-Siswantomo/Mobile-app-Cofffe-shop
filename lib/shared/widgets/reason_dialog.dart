import 'package:flutter/material.dart';

import 'dialog_action_row.dart';

class ReasonDialog extends StatefulWidget {
  const ReasonDialog({
    super.key,
    required this.title,
    required this.confirmLabel,
    this.isDestructive = false,
  });

  final String title;
  final String confirmLabel;
  final bool isDestructive;

  @override
  State<ReasonDialog> createState() => _ReasonDialogState();
}

class _ReasonDialogState extends State<ReasonDialog> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Tulis alasan',
            helperText: 'Wajib diisi',
          ),
          maxLines: 3,
          textInputAction: TextInputAction.done,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Alasan wajib diisi';
            }

            return null;
          },
          onFieldSubmitted: (_) => _submit(),
        ),
      ),
      actions: [
        DialogActionRow(
          cancelLabel: 'Kembali',
          confirmLabel: widget.confirmLabel,
          isDestructive: widget.isDestructive,
          onCancel: () => Navigator.of(context).pop(),
          onConfirm: _submit,
        ),
      ],
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop(_controller.text.trim());
    }
  }
}
