import 'package:flutter/material.dart';
import 'package:score/features/score/presentation/pages/score/player_score_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();

  void navigateToScorePage() {
    final String player1Name = _player1Controller.text;
    final String player2Name = _player2Controller.text;

    if (player1Name.isNotEmpty && player2Name.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerScorePage(
            player1Name: player1Name,
            player2Name: player2Name,
          ),
        ),
      );
      // Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          "Командалардын атын жазыңыз!",
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                controller: _player1Controller,
                decoration: const InputDecoration(
                  labelText: "1-команданын аты",
                  labelStyle: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                textCapitalization: TextCapitalization.characters,
                controller: _player2Controller,
                decoration: const InputDecoration(
                  labelText: "2-команданын аты",
                  labelStyle: TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: navigateToScorePage,
                child: const SizedBox(
                  width: 200,
                  height: 40,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.cyan,
                          Colors.blue,
                          Colors.red,
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
