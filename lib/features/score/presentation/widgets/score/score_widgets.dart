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
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(playerName,
                          style: TextStyle(
                            fontSize: constraints.maxHeight * 0.07,
                            color: AppColors.white,
                            fontFamily: 'IBMPlexSansArabic',
                          )),
                      Text('${state.getScores(player)}',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * 0.5,
                            color: AppColors.white,
                            fontFamily: 'IBMPlexSansArabic',
                          )),
                      IconButton(
                        icon: Icon(
                          Icons.undo,
                          color: AppColors.white,
                          size: constraints.maxHeight * 0.08,
                        ),
                        onPressed: () =>
                            context.read<ScoreCubit>().undoScore(player),
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
