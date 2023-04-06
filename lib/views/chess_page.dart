import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/horse_movement_cubit.dart';
import '../bloc/horse_active_cubit.dart';
import 'chess_form.dart';

class ChessPage extends StatelessWidget {
  const ChessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HorseMovementCubit()..move(0, 0),
        ),
        BlocProvider(
          create: (context) => HorseActiveCubit(),
        )
      ],
      child: ChessForm(),
    );
  }
}
