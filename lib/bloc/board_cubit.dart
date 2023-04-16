import 'package:flutter_bloc/flutter_bloc.dart';

class BoardCubit extends Cubit<List<List<String>>> {
  BoardCubit()
      : super([
          ['bR', 'bN', 'bB', 'bQ', 'bK', 'bB', 'bN', 'bR'],
          ['bP', 'bP', 'bP', 'bP', 'bP', 'bP', 'bP', 'bP'],
          ['em', 'em', 'em', 'em', 'em', 'em', 'em', 'em'],
          ['em', 'em', 'em', 'em', 'em', 'em', 'em', 'em'],
          ['em', 'em', 'em', 'em', 'em', 'em', 'em', 'em'],
          ['em', 'em', 'em', 'em', 'em', 'em', 'em', 'em'],
          ['wP', 'wP', 'wP', 'wP', 'wP', 'wP', 'wP', 'wP'],
          ['wR', 'wN', 'wB', 'wQ', 'wK', 'wB', 'wN', 'wR'],
        ]);

  void move(
      {required int fromX,
      required int fromY,
      required int toX,
      required int toy,
      required List<List<String>> board}) {
    board[toy][toX] = board[fromY][fromX];
    board[fromY][fromX] = 'em';
    emit(board);
  }
}
