import 'package:flutter/material.dart';

class MyExitCorfirmationDialog extends StatelessWidget {
  const MyExitCorfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text(
          "Tиркемеден чыгууну каалайсызбы?",
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          TextButton(
            child: const Text("Жок"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text("Ооба"),
            onPressed: () => Navigator.of(context).pop(true),
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const PlayerNameInputPage())),
          )
        ]);
  }
}
