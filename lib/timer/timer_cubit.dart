import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import './ticker.dart';

class TimerCubit extends Cubit<DateTime> {
  TimerCubit() : super(DateTime.now());

  void reset() => emit(DateTime.now());
}

class DurationCubit extends Cubit<Duration> {
  DurationCubit() : super(const Duration(seconds: 0));
  final Ticker ticker = const Ticker();

  StreamSubscription<Duration>? _tickerSubscription;

  void startTimer() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        ticker.tick(DateTime.now()).listen((event) => emit(event));
  }
}
