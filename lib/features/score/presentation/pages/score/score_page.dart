import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/config/theme/app_colors.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';
import 'package:score/features/score/presentation/cubit/score_state.dart';
import 'package:score/features/score/presentation/widgets/score/score_row_widget.dart';
import 'package:score/features/score/presentation/widgets/score/score_widgets.dart';

class PlayerScorePage extends StatelessWidget {
  const PlayerScorePage({super.key});

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
            const Row(
              children: [
                PlayerScoreWidget(player: 1),
                PlayerScoreWidget(player: 2),
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
                        return buildScoreRow(
                            context, state.raund1, state.raund2);
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
