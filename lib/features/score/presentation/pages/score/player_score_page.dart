import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/config/theme/app_colors.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';
import 'package:score/features/score/presentation/cubit/score_state.dart';
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
    return Scaffold(
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
                onPressed: () => context.read<ScoreCubit>().resetScores(),
              ),
            ),
          ],
        );
      }),
    );
  }
}
