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

  static const Map<String, int> priorityboard = {
    'bQ': 1,
    'bK': 2,
    'bR': 3,
    'bN': 4,
    'bB': 4,
    'bP': 5,
    'em': 6
  };

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

  void displayExpectedPoints(int x, int y, List<List<String>> board) {
    // Clear all the points horse expected old in board to  -1
    reset();

    // The maximum number of possibilities to move the horse are 8
    // The position of the horse (increases or decreases) for both (X or Y axes) (2 or 1)
    // condition The rate of (increase or decrease) in both (X or Y axes) is not equal
    int expectedX;
    int expectedY;
    expectedX = x - 1;
    expectedY = y - 2;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x + 1;
    expectedY = y - 2;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x + 2;
    expectedY = y - 1;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x - 2;
    expectedY = y - 1;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x - 2;
    expectedY = y + 1;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x - 1;
    expectedY = y + 2;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x + 1;
    expectedY = y + 2;
    checkIsValidTOAdd(expectedX, expectedY, board);

    expectedX = x + 2;
    expectedY = y + 1;
    checkIsValidTOAdd(expectedX, expectedY, board);

    if (pointMaxPriority.isNotEmpty) {
      boardExpected[pointMaxPriority[0]][pointMaxPriority[1]] = 0;
    }
    pointMaxPriority.clear();
    maxPriority = double.maxFinite.toInt();
    emit(boardExpected);
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

  int maxPriority = double.maxFinite.toInt();
  late List pointMaxPriority;

  /// Check if expected X and expected Y  are valid(They are not out of board) to put them in   board
  void checkIsValidTOAdd(
      int expectedX, int expectedY, List<List<String>> board) {
    if (expectedX > -1 &&
        expectedX < 8 &&
        expectedY > -1 &&
        expectedY < 8 &&
        priorityboard.containsKey(board[expectedY][expectedX])) {
      boardExpected[expectedY][expectedX] =
          priorityboard[board[expectedY][expectedX]]!;
      if (priorityboard[board[expectedY][expectedX]]! < maxPriority &&
          priorityboard[board[expectedY][expectedX]]! != 6) {
        maxPriority = priorityboard[board[expectedY][expectedX]]!;
        pointMaxPriority = [expectedY, expectedX];
      }
    }
  }
}
