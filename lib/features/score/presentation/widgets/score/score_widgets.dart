import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/config/theme/app_colors.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';
import 'package:score/features/score/presentation/cubit/score_state.dart';

class PlayerScoreWidget extends StatelessWidget {
  final String playerName;
  final int player;

  const PlayerScoreWidget(
      {super.key, required this.player, required this.playerName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreCubit, ScoreState>(
      builder: (context, state) {
        // bool gameEnded = (player == 1 && state.first == 45 ||
        //     player == 2 && state.second == 45);
        return Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: player == 1 ? AppColors.red : AppColors.blue,
              image: player == 1 && state.imgBgr1
                  ? const DecorationImage(
                      image: AssetImage(
                        "assets/images/hands_up.png",
                      ),
                      alignment: Alignment.bottomCenter,
                      opacity: 0.2,
                      fit: BoxFit.fitWidth,
                    )
                  : player == 2 && state.imgBgr2
                      ? const DecorationImage(
                          image: AssetImage("assets/images/hands_up.png"),
                          alignment: Alignment.bottomCenter,
                          opacity: 0.2,
                          fit: BoxFit.fitWidth,
                        )
                      : null,
            ),
            child: InkWell(
              onTap: () => context.read<ScoreCubit>().incrementScore(player),
              child: LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                  height: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        top: 10,
                        child: Text(playerName,
                            style: TextStyle(
                              fontSize: constraints.maxHeight * 0.08,
                              color: AppColors.white,
                              fontFamily: 'IBMPlexSansArabic',
                              fontWeight: FontWeight.w800,
                            )),
                      ),
                      Text(
                        "${state.getScores(player)}",
                        style: TextStyle(
                          fontSize: constraints.maxHeight * 0.5,
                          color: AppColors.white,
                          fontFamily: 'IBMPlexSansArabic',
                        ),
                      ),
                      // Visibility(
                      //   visible: gameEnded,
                      //   child: const Positioned(
                      //     top: 30,
                      //     child: Text(
                      //       "WIN",
                      //       style: TextStyle(fontSize: 30),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        bottom: 13,
                        child: IconButton(
                          icon: Icon(
                            Icons.undo,
                            color: AppColors.white,
                            size: constraints.maxHeight * 0.12,
                          ),
                          onPressed: () =>
                              context.read<ScoreCubit>().undoScore(player),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
