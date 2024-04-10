import 'package:flutter/material.dart';

class MyExitCorfirmationDialog extends StatelessWidget {
  const MyExitCorfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Are you sure you want to exit?"),
        actions: [
          TextButton(
            child: const Text("No"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text("Yes"),
            onPressed: () => Navigator.of(context).pop(true),
          )
        ]);
  }
}
