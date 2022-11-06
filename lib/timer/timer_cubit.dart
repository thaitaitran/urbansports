import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import './ticker.dart';
import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  const TimerState({required this.checkIn, required this.checkedInSeconds});
  final DateTime checkIn;
  final int checkedInSeconds;

  TimerState copyWith({required int seconds}) {
    return TimerState(checkIn: checkIn, checkedInSeconds: seconds);
  }

  @override
  List<Object> get props => [checkIn, checkedInSeconds];
}

class TimerCubit extends Cubit<TimerState> {
  final Ticker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  TimerCubit({required Ticker ticker})
      : _ticker = ticker,
        super(TimerState(checkIn: DateTime.now(), checkedInSeconds: 0));

  void startTimer() {
    emit(TimerState(checkIn: DateTime.now(), checkedInSeconds: 0));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker.tick().listen((_) {
      final now = DateTime.now();
      emit(state.copyWith(seconds: now.difference(state.checkIn).inSeconds));
    });
  }
}
