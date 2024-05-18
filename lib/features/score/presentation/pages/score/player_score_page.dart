import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/config/theme/app_colors.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';
import 'package:score/features/score/presentation/cubit/score_state.dart';
import 'package:score/features/score/presentation/pages/score/dialog.dart';
import 'package:score/features/score/presentation/pages/score/exit_confirmation_dialog.dart';
import 'package:score/features/score/presentation/widgets/score/score_row_widget.dart';
import 'package:score/features/score/presentation/widgets/score/score_widgets.dart';

class PlayerScorePage extends StatefulWidget {
  final String player1Name;
  final String player2Name;
  const PlayerScorePage(
      {super.key, required this.player1Name, required this.player2Name});

  @override
  State<PlayerScorePage> createState() => _PlayerScorePageState();
}

class _PlayerScorePageState extends State<PlayerScorePage> {
  bool _showDialog = true;

  @override
  void initState() {
    super.initState();
    if (_showDialog) {
      Future.delayed(const Duration(seconds: 3), () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const MyWidget();
            });
      });
      _showDialog = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        didPop = await showDialog(
            context: context,
            builder: (context) => const MyExitCorfirmationDialog());
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(),
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  PlayerScoreWidget(
                    player: 1,
                    playerName: widget.player1Name,
                  ),
                  PlayerScoreWidget(
                    player: 2,
                    playerName: widget.player2Name,
                  ),
                ],
              ),
              Positioned(
                top: 5,
                child: SizedBox(
                    width: constraints.maxWidth * 0.17,
                    height: constraints.maxHeight * 0.1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: BlocBuilder<ScoreCubit, ScoreState>(
                        builder: (context, state) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: buildScoreRow(
                                context, state.raund1, state.raund2),
                          );
                        },
                      ),
                    )),
              ),
              Positioned(
                bottom: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: AppColors.white,
                    size: constraints.maxHeight * 0.1,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              "Бардык упайлар өчүрүлсүнбү?",
                              style: TextStyle(fontSize: 17),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "Жок",
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    context.read<ScoreCubit>().resetScores();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Ооба",
                                  ))
                            ],
                          );
                        });
                  },
                ),
              ),
              BlocBuilder<ScoreCubit, ScoreState>(
                builder: (context, state) {
                  if (state.isWinning) {
                    return Center(
                      child: GestureDetector(
                        onTap: state.hasWon
                            ? () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PlayerScorePage(
                                            player1Name: '',
                                            player2Name: '',
                                          )),
                                );
                              }
                            : null,
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "🏆",
                                        style: TextStyle(
                                          fontSize: 98.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: '${widget.player1Name}: ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 37,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: state.first.toString(),
                                            style: const TextStyle(
                                                color: Colors.red,
                                                fontSize: 37,
                                                fontWeight: FontWeight.bold)),
                                        const TextSpan(
                                            text: " - ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 37,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: '${widget.player2Name}: ',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 37,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: state.second.toString(),
                                            style: const TextStyle(
                                                color: Colors.blue,
                                                fontSize: 37,
                                                fontWeight: FontWeight.bold)),
                                      ])),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const TextSpan(
                                              text: 'Жеңүүчү : ',
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    215, 255, 235, 59),
                                                fontSize: 49,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: state.first > state.second
                                                  ? widget.player1Name
                                                  : widget.player2Name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 49,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' ${state.getWinningScore()}',
                                              style: TextStyle(
                                                color:
                                                    state.first > state.second
                                                        ? Colors.red
                                                        : Colors.blue,
                                                fontSize: 49,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
