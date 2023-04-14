import 'package:chess/bloc/board_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/horse_expected_points_cubit.dart';
import 'chess_form.dart';

class ChessPage extends StatelessWidget {
  const ChessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HorseExpectedPointsCubit(),
        ),
        BlocProvider(
          create: (context) => BoardCubit(),
        )
      ],
      child: ChessForm(),
    );
  }
}
