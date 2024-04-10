import 'package:flutter/material.dart';
import 'package:score/features/score/presentation/pages/pages.dart';

class PlayerNameInputPage extends StatefulWidget {
  const PlayerNameInputPage({super.key});

  @override
  State<PlayerNameInputPage> createState() => _PlayerNameInputPageState();
}

class _PlayerNameInputPageState extends State<PlayerNameInputPage> {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
          "Please enter player names",
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _player1Controller,
                decoration: const InputDecoration(
                  labelText: "Player1 Name",
                  labelStyle: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: _player2Controller,
                decoration: const InputDecoration(
                  labelText: "Player2 Name",
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
                            // Colors.cyan,
                            Colors.blue,
                            Colors.red,
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        "Start",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold),
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
