import 'package:flutter/material.dart';
import 'package:score/features/score/presentation/widgets/score/score_inkwell_widget.dart';

Widget buildScoreRow(BuildContext context, int raund1, int raund2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      buildScoreInkWell(context, raund1, 1),
      buildScoreInkWell(context, raund2, 2),
    ],
  );
}
