import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/chess_cubit.dart';
import 'chess_form.dart';

class ChessPage extends StatelessWidget {
  const ChessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChessCubit>(
      create: (context) => ChessCubit()..move(0, 0),
      child: const ChessForm(),
    );
  }
}
