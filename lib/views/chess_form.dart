import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/horse_movement_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

import '../bloc/horse_active_cubit.dart';

class ChessForm extends StatelessWidget {
  ChessForm({super.key});
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    bool active = context.watch<HorseActiveCubit>().state;
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocBuilder<HorseMovementCubit, List<List<int>>>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: Column(
            children: [
              const Spacer(),
              ...List.generate(
                  8,
                  (x) => Row(
                        children: [
                          ...List.generate(
                              8,
                              (y) => InkWell(
                                    onTap: () {
                                      if (state[x][y] == 0) {
                                        context
                                            .read<HorseActiveCubit>()
                                            .changeActiveMode();
                                      } else if (state[x][y] == 1 && active) {
                                        player.play(AssetSource('sound.mp3'));
                                        context
                                            .read<HorseActiveCubit>()
                                            .changeActiveMode();
                                        context
                                            .read<HorseMovementCubit>()
                                            .move(y, x);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: buildcolor(x, y),
                                          border: state[x][y] == 1 && active
                                              ? Border.all(
                                                  color: Colors.red,
                                                  width: 5,
                                                )
                                              : null),
                                      width: isPortrait
                                          ? MediaQuery.of(context).size.width /
                                              8
                                          : MediaQuery.of(context).size.height /
                                              10,
                                      height: isPortrait
                                          ? MediaQuery.of(context).size.width /
                                              8
                                          : MediaQuery.of(context).size.height /
                                              10,
                                      child: state[x][y] == 0
                                          ? Center(
                                              child: Image.asset(
                                                'assets/horse.png',
                                              ),
                                            )
                                          : null,
                                    ),
                                  ))
                        ],
                      )),
              const Spacer(),
            ],
          ),
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
