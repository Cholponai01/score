import 'package:equatable/equatable.dart';

class ScoreState extends Equatable {
  final int first;
  final int second;
  final int raund1;
  final int raund2;
  final bool imgBgr1;
  final bool imgBgr2;
  final bool gameEnded;
  final bool isWinning;
  final bool hasWon;

  const ScoreState({
    this.first = 0,
    this.second = 0,
    this.raund1 = 0,
    this.raund2 = 0,
    this.imgBgr1 = false,
    this.imgBgr2 = false,
    this.gameEnded = false,
    this.isWinning = false,
    this.hasWon = false,
  });

  int getScores(int player) {
    return player == 1 ? first : second;
  }

  int getWinningScore() {
    return first > second ? first : second;
  }

  ScoreState incrementScore(int player) {
    int newFirst = first;
    int newSecond = second;
    int newRaund1 = raund1;
    int newRaund2 = raund2;
    bool newHasWon = (newFirst == 45 || newSecond == 45);

    if (player == 1 && newFirst < 46) {
      newFirst = newFirst + 1;
      // if (newFirst == 45) {
      //   newRaund1 = newRaund1 + 1;
      //   if (newRaund1 == 7) {
      //     newRaund1 = 0;
      //   }
      // }
    } else if (player == 2 && newSecond < 46) {
      newSecond = newSecond + 1;
      // if (newSecond == 45) {
      //   newRaund2 = newRaund2 + 1;
      //   if (newRaund2 == 7) {
      //     newRaund2 = 0;
      //   }
      // }
    }

    if (newFirst == 46 || newSecond == 46) {
      newFirst = 0;
      newSecond = 0;
    }

    // if (newSecond == 46) {
    //   newSecond = 0;
    // }

    bool gameEnded =
        (newFirst == 45 || newSecond == 45) && newFirst == 0 && newSecond == 0;

    bool isWinning = (newFirst == 45 || newSecond == 45);

    return ScoreState(
      first: newFirst,
      second: newSecond,
      raund1: newRaund1,
      raund2: newRaund2,
      imgBgr1: player == 1 ? true : false,
      imgBgr2: player == 2 ? true : false,
      gameEnded: gameEnded,
      isWinning: isWinning,
      hasWon: newHasWon,
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

    // if (newRaund1 == 1 && newRaund1 > 0) {
    //   newRaund1 = newRaund1 - 1;
    // } else if (newRaund2 == 2 && newRaund2 > 0) {
    //   newRaund2 = newRaund2 - 1;
    // }

    return ScoreState(
      first: newFirst,
      second: newSecond,
      raund1: newRaund1,
      raund2: newRaund2,
      gameEnded: gameEnded,
    );
  }

  ScoreState incrementRaund(int raund) {
    int newRaund1 = raund1;
    int newRaund2 = raund2;

    if (raund == 1 && newRaund1 < 7) {
      newRaund1 = newRaund1 + 1;
    } else if (raund == 2 && newRaund2 < 7) {
      newRaund2 = newRaund2 + 1;
    }

    if (newRaund1 == 7) {
      newRaund1 = 0;
    }

    if (newRaund2 == 7) {
      newRaund2 = 0;
    }

    return ScoreState(
      first: first,
      second: second,
      raund1: newRaund1,
      raund2: newRaund2,
      imgBgr1: imgBgr1,
      imgBgr2: imgBgr2,
      gameEnded: gameEnded,
    );
  }

  @override
  List<Object?> get props => [
        first,
        second,
        raund1,
        raund2,
        imgBgr1,
        imgBgr2,
        gameEnded,
        isWinning,
      ];
}
