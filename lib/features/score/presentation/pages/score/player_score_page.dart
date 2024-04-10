import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/config/theme/app_colors.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';
import 'package:score/features/score/presentation/cubit/score_state.dart';
import 'package:score/features/score/presentation/pages/score/exit_confirmation_dialog.dart';
import 'package:score/features/score/presentation/pages/score/player_name_input_page.dart';
import 'package:score/features/score/presentation/widgets/score/score_row_widget.dart';
import 'package:score/features/score/presentation/widgets/score/score_widgets.dart';

class PlayerScorePage extends StatelessWidget {
  final String player1Name;
  final String player2Name;
  const PlayerScorePage(
      {super.key, required this.player1Name, required this.player2Name});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        didPop = await showDialog(
            context: context,
            builder: (context) => const MyExitCorfirmationDialog());
        return Future.value(didPop == true);
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
                    playerName: player1Name,
                  ),
                  PlayerScoreWidget(
                    player: 2,
                    playerName: player2Name,
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
                bottom: 40,
                child: IconButton(
                  icon: Icon(
                    Icons.home,
                    color: AppColors.white,
                    size: constraints.maxHeight * 0.08,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlayerNameInputPage())),
                ),
              ),
              Positioned(
                bottom: 5,
                child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: AppColors.white,
                    size: constraints.maxHeight * 0.08,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                                "Do you really want to delete all scores"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "No",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    context.read<ScoreCubit>().resetScores();
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Yes",
                                      style: TextStyle(fontSize: 17)))
                            ],
                          );
                        });
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
