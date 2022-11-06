import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import './ticker.dart';
import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  const TimerState({required this.checkIn, required this.checkedInSeconds});
  final DateTime checkIn;
  final int checkedInSeconds;

  @override
  List<Object> get props => [checkIn, checkedInSeconds];
}

class TimerInitial extends TimerState {
  TimerInitial() : super(checkIn: DateTime.now(), checkedInSeconds: 0);
}

class TimerRunning extends TimerState {
  const TimerRunning(checkIn, checkedInSeconds)
      : super(checkIn: checkIn, checkedInSeconds: checkedInSeconds);
}

class TimerCubit extends Cubit<TimerState> {
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  TimerCubit({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial());

  void startTimer() {
    emit(TimerInitial());
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick().listen((_) {
      final now = DateTime.now();
      emit(
          TimerRunning(state.checkIn, now.difference(state.checkIn).inSeconds));
    });
  }
}
