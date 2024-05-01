import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:score/features/score/presentation/cubit/score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(const ScoreState());

  void incrementScore(int player) {
    emit(state.incrementScore(player));
  }

  void undoScore(int player) {
    emit(state.undoScore(player));
  }

  void resetScores() {
    emit(const ScoreState());
  }

  void incrementRaund(int raund) {
    emit(state.incrementRaund(raund));
  }

  void reset() {
    resetScores();
  }
}
