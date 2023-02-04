import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'checkin_data_event.dart';
part 'checkin_data_state.dart';

class CheckinDataBloc extends Bloc<CheckinDataEvent, CheckinDataState> {
  CheckinDataBloc() : super(const CheckinDataState.empty()) {
    on<CheckinDataEvent>((event, emit) {
      try {
        String scannedUrl = state.url;
        if (!scannedUrl.startsWith("http")) {
          scannedUrl = "not a valid url";
        }
        emit(
          CheckinDataState(
            url: scannedUrl,
          ),
        );
      } on Exception catch (e) {
        // ignore: avoid_print
        print(e);
      }
    });
  }
}
