import 'package:flutter/material.dart';

class ErrorMessage extends StatefulWidget {
  final String message;
  final bool isDialogueShow;
  final VoidCallback? func;
  final String? funcTitle;
  const ErrorMessage({
    required this.message,
    this.isDialogueShow = false,
    this.func,
    this.funcTitle,
    super.key,
  });

  @override
  State<ErrorMessage> createState() => _ErrorMessageState();
}

class _ErrorMessageState extends State<ErrorMessage> {
  @override
  void initState() {
    super.initState();
    if (widget.isDialogueShow) {
      Future.delayed(Duration.zero, () {
        dialoge();
      });
    }
  }

  Future<void> dialoge() async {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(widget.message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text("close"),
            ),
          ),
          if (widget.func != null)
            TextButton(
              onPressed: () {
                widget.func!();
                Navigator.of(ctx).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                child: Text(widget.funcTitle ?? ''),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.message),
    );
  }
}
