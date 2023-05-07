import 'package:flutter_bloc/flutter_bloc.dart';

class HorseExpectedPointsCubit extends Cubit<List<List<int>>> {
  HorseExpectedPointsCubit()
      : super([
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
          [-1, -1, -1, -1, -1, -1, -1, -1],
        ]);

  Map<String, int> priorityboard = {
    'bQ': 1,
    'bK': 2,
    'bR': 3,
    'bN': 4,
    'bB': 4,
    'bP': 5,
    'em': 6
  };

  int maxPriority = double.maxFinite.toInt();
  late List pointMaxPriority;

  // We initialize All points in  board Expected = -1
  List<List<int>> boardExpected = [
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
  ];

  //  -1  refers to  is not expected points
  //  else  refers the expected points And its priority

  List<int> xPoints = [2, 1, -1, -2, -2, -1, 1, 2];
  List<int> yPoints = [1, 2, 2, 1, -1, -2, -2, -1];

  void displayExpectedPoints(int x, int y, List<List<String>> board) {
    // Clear all the points horse expected old in board to  -1
    reset();

    // The maximum number of possibilities to move the horse are 8
    // The position of the horse (increases or decreases) for both (X or Y axes) (2 or 1)
    // condition The rate of (increase or decrease) in both (X or Y axes) is not equal
    for (int i = 0; i < 8; i++) {
      int expectedY = y + yPoints[i];
      int expectedX = x + xPoints[i];
      String possiblePointPiece = board[yPoints[i]][xPoints[i]];
      if (checkIsValidTOAdd(expectedX, expectedY, possiblePointPiece)) {
        boardExpected[expectedY][expectedX] =
            priorityboard[possiblePointPiece]!;
        int priorityPoint = priorityboard[possiblePointPiece]!;
        maximumPriority(priorityPoint, expectedY, expectedX);
      }
    }

    if (pointMaxPriority.isNotEmpty) {
      boardExpected[pointMaxPriority[0]][pointMaxPriority[1]] = 0;
    }
    pointMaxPriority.clear();
    maxPriority = double.maxFinite.toInt();
    emit(boardExpected);
  }

  void maximumPriority(int priorityPoint, int expectedY, int expectedX) {
    if (priorityPoint < maxPriority && priorityPoint != 6) {
      maxPriority = priorityPoint;
      pointMaxPriority = [expectedY, expectedX];
    }
  }

  void reset() {
    boardExpected = [
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
      [-1, -1, -1, -1, -1, -1, -1, -1],
    ];
    emit(boardExpected);
  }

  /// Check if expected X and expected Y  are valid(They are not out of board) to put them in   board
  bool checkIsValidTOAdd(
      int expectedX, int expectedY, String newExpectedPoint) {
    if (expectedX > -1 &&
        expectedX < 8 &&
        expectedY > -1 &&
        expectedY < 8 &&
        priorityboard.containsKey(newExpectedPoint)) {
      return true;
    }
    return false;
  }
}
