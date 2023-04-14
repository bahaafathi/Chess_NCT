import 'package:chess/bloc/board_cubit.dart';
import 'package:chess/resources/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/horse_expected_points_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

class ChessForm extends StatelessWidget {
  ChessForm({super.key});
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    int preX = -1;
    int prey = -1;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocBuilder<BoardCubit, List<List<String>>>(
      builder: (context, boardState) {
        return BlocBuilder<HorseExpectedPointsCubit, List<List<int>>>(
          builder: (context, stateExpectedPoints) {
            return Scaffold(
              backgroundColor: Colors.blue,
              body: Column(
                children: [
                  const Spacer(),
                  ...List.generate(
                      // Create 8 rows
                      8,
                      (y) => Row(
                            children: [
                              ...List.generate(
                                // Create 8 Column
                                8,
                                (x) => InkWell(
                                  onTap: () {
                                    if (x == preX && y == prey) {
                                      preX = -1;
                                      prey = -1;
                                      context
                                          .read<HorseExpectedPointsCubit>()
                                          .reset();
                                      return;
                                    }
                                    if (boardState[y][x] == 'wN') {
                                      preX = x;
                                      prey = y;
                                      context
                                          .read<HorseExpectedPointsCubit>()
                                          .displayExpectedPoints(
                                              x, y, boardState);
                                    } else if (HorseExpectedPointsCubit
                                            .priorityboard
                                            .containsValue(
                                                stateExpectedPoints[y][x]) ||
                                        stateExpectedPoints[y][x] == 0) {
                                      context
                                          .read<HorseExpectedPointsCubit>()
                                          .reset();

                                      context.read<BoardCubit>().move(
                                          fromX: preX,
                                          fromY: prey,
                                          toX: x,
                                          toy: y,
                                          board: boardState);
                                      player.play(AssetSource('sound.mp3'));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: buildcolor(x, y),
                                        border: stateExpectedPoints[y][x] != -1
                                            ? Border.all(
                                                color: stateExpectedPoints[y]
                                                            [x] ==
                                                        0
                                                    ? Colors.red
                                                    : Colors.blue,
                                                width: 10 -
                                                    stateExpectedPoints[y][x]
                                                        .toDouble(),
                                              )
                                            : null),
                                    width: isPortrait
                                        ? MediaQuery.of(context).size.width / 8
                                        : MediaQuery.of(context).size.height /
                                            10,
                                    height: isPortrait
                                        ? MediaQuery.of(context).size.width / 8
                                        : MediaQuery.of(context).size.height /
                                            10,
                                    child: Center(
                                      child: (() {
                                        switch (boardState[y][x]) {
                                          case 'bB':
                                            return Image.asset(AppImages.bB);
                                          case 'bK':
                                            return Image.asset(AppImages.bK);
                                          case 'bN':
                                            return Image.asset(AppImages.bN);
                                          case 'bP':
                                            return Image.asset(AppImages.bP);
                                          case 'bQ':
                                            return Image.asset(AppImages.bQ);
                                          case 'bR':
                                            return Image.asset(AppImages.bR);
                                          case 'wB':
                                            return Image.asset(AppImages.wB);
                                          case 'wK':
                                            return Image.asset(AppImages.wK);
                                          case 'wN':
                                            return Image.asset(AppImages.wN);
                                          case 'wP':
                                            return Image.asset(AppImages.wP);
                                          case 'wQ':
                                            return Image.asset(AppImages.wQ);
                                          case 'wR':
                                            return Image.asset(AppImages.wR);
                                          default:
                                            return null;
                                        }
                                      })(),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                  const Spacer(),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Color buildcolor(int x, int y) {
  int temp = x;
  if (y.isEven) temp++;

  return temp.isEven ? Colors.green : Colors.white;
}
