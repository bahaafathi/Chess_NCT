import 'package:flutter_bloc/flutter_bloc.dart';

class HorseActiveCubit extends Cubit<bool> {
  HorseActiveCubit() : super(false);

  void changeActiveMode() {
    emit(!state);
  }
}
