import 'package:equatable/equatable.dart';

class ScoreState extends Equatable {
  final int first;
  final int second;
  final int raund1;
  final int raund2;
  final bool imgBgr1;
  final bool imgBgr2;

  const ScoreState({
    this.first = 0,
    this.second = 0,
    this.raund1 = 0,
    this.raund2 = 0,
    this.imgBgr1 = false,
    this.imgBgr2 = false,
  });

  int getScores(int player) {
    return player == 1 ? first : second;
  }

  ScoreState incrementScore(int player) {
    int newFirst = first;
    int newSecond = second;

    if (player == 1 && newFirst < 35) {
      newFirst = newFirst + 1;
    } else if (player == 2 && newSecond < 35) {
      newSecond = newSecond + 1;
    }

    return ScoreState(
      first: newFirst,
      second: newSecond,
      raund1: raund1,
      raund2: raund2,
      imgBgr1: player == 1 ? true : false,
      imgBgr2: player == 2 ? true : false,
    );
  }

  ScoreState undoScore(int player) {
    int newFirst = first;
    int newSecond = second;

    if (player == 1 && newFirst > 0) {
      newFirst = newFirst - 1;
    } else if (player == 2 && newSecond > 0) {
      newSecond = newSecond - 1;
    }

    int newRaund1 = raund1;
    int newRaund2 = raund2;

    if (raund1 == 1 && newRaund1 > 0) {
      newRaund1 = newRaund1 - 1;
    } else if (raund2 == 2 && newRaund2 > 0) {
      newRaund2 = newRaund2 - 1;
    }

    return ScoreState(
      first: newFirst,
      second: newSecond,
      raund1: newRaund1,
      raund2: newRaund2,
    );
  }

  ScoreState incrementRaund(int raund) {
    int newRaund1 = raund1;
    int newRaund2 = raund2;

    if (raund == 1 && newRaund1 < 6) {
      newRaund1 = newRaund1 + 1;
    } else if (raund == 2 && newRaund2 < 6) {
      newRaund2 = newRaund2 + 1;
    }

    return ScoreState(
      first: first,
      second: second,
      raund1: newRaund1,
      raund2: newRaund2,
      imgBgr1: imgBgr1,
      imgBgr2: imgBgr2,
    );
  }

  @override
  List<Object?> get props => [first, second, raund1, raund2, imgBgr1, imgBgr2];
}
