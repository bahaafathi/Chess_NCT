import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chess_cubit.dart';
import 'package:audioplayers/audioplayers.dart';

class ChessForm extends StatefulWidget {
  const ChessForm({super.key});

  @override
  State<ChessForm> createState() => _ChessFormState();
}

class _ChessFormState extends State<ChessForm> {
  final player = AudioPlayer();

  bool active = false;
  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return BlocBuilder<ChessCubit, List<List<int>>>(
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
                                        setState(() {
                                          active = true;
                                        });
                                      } else if (state[x][y] == 1 && active) {
                                        player.play(AssetSource('sound.mp3'));
                                        setState(() {
                                          active = false;
                                        });
                                        context.read<ChessCubit>().move(y, x);
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
