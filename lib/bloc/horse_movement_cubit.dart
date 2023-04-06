import 'package:flutter_bloc/flutter_bloc.dart';

class HorseMovementCubit extends Cubit<List<List<int>>> {
  HorseMovementCubit() : super([]);

  // This variable is specific to knowing the horse's available points
  // We will use it if the horse moves and delete all these values from the bord
  List<List<int>> pointsExpected = [];

  // This variable is responsible for bord Chess
  // We initialize All points in  bord -1

  List<List<int>> bord = [
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
    [-1, -1, -1, -1, -1, -1, -1, -1],
  ];
  //  0  refers to horse place
  //  1  refers the expected points for the horse to move
  //  -1  refers to is not horse place && is not expected points

  //This function puts the place of the horse and the places it is expected for
  void move(int x, int y) {
    // Clear all the points horse expected old in bord to  -1
    for (List list in pointsExpected) {
      bord[list[0]][list[1]] = -1;
    }

    // Put a point in the new location of the horse
    bord[y][x] = 0;

    // The maximum number of possibilities to move the horse are 8
    // The position of the horse (increases or decreases) for both (X or Y axes) (2 or 1)
    // condition The rate of (increase or decrease) in both (X or Y axes) is not equal
    int expectedX;
    int expectedY;
    expectedX = x - 1;
    expectedY = y - 2;
    checkIsValid(expectedX, expectedY);

    expectedX = x + 1;
    expectedY = y - 2;
    checkIsValid(expectedX, expectedY);

    expectedX = x + 2;
    expectedY = y - 1;
    checkIsValid(expectedX, expectedY);

    expectedX = x - 2;
    expectedY = y - 1;
    checkIsValid(expectedX, expectedY);

    expectedX = x - 2;
    expectedY = y + 1;
    checkIsValid(expectedX, expectedY);

    expectedX = x - 1;
    expectedY = y + 2;
    checkIsValid(expectedX, expectedY);

    expectedX = x + 1;
    expectedY = y + 2;
    checkIsValid(expectedX, expectedY);

    expectedX = x + 2;
    expectedY = y + 1;
    checkIsValid(expectedX, expectedY);

    emit(bord);
  }

  /// Check if expected X and expected Y  are valid(They are not out of bord) to put them in pointsExpected and bord
  void checkIsValid(int expectedX, int expectedY) {
    if (expectedX > -1 && expectedX < 8 && expectedY > -1 && expectedY < 8) {
      pointsExpected.add([expectedY, expectedX]);
      bord[expectedY][expectedX] = 1;
    }
  }
}
