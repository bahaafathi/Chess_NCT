import 'package:flutter_bloc/flutter_bloc.dart';

class ChessCubit extends Cubit<List<List<int>>> {
  List<List<int>> temp = [];
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
  ChessCubit() : super([]);

  void move(int x, int y) {
    for (List list in temp) {
      bord[list[0]][list[1]] = -1;
    }
    bord[y][x] = 0;
    int newx;
    int newy;
    newx = x - 1;
    newy = y - 2;
    checkIsValid(newx, newy);

    newx = x + 1;
    newy = y - 2;
    checkIsValid(newx, newy);

    newx = x + 2;
    newy = y - 1;
    checkIsValid(newx, newy);

    newx = x - 2;
    newy = y - 1;
    checkIsValid(newx, newy);

    newx = x - 2;
    newy = y + 1;
    checkIsValid(newx, newy);

    newx = x - 1;
    newy = y + 2;
    checkIsValid(newx, newy);

    newx = x + 1;
    newy = y + 2;
    checkIsValid(newx, newy);

    newx = x + 2;
    newy = y + 1;
    checkIsValid(newx, newy);

    emit(bord);
  }

  void checkIsValid(int newx, int newy) {
    if (newx > -1 && newx < 8 && newy > -1 && newy < 8) {
      temp.add([newy, newx]);
      bord[newy][newx] = 1;
    }
  }
}
