import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/features/score/presentation/cubit/score_cubit.dart';

Widget buildScoreInkWell(BuildContext context, int score, int player) {
  return InkWell(
    onTap: () => context.read<ScoreCubit>().incrementRaund(player),
    child: LayoutBuilder(builder: (context, constraints) {
      return Text(
        "$score",
        style: TextStyle(
          fontSize: constraints.maxHeight * 0.78,
          fontFamily: 'IBMPlexSansArabic',
        ),
      );
    }),
  );
}
