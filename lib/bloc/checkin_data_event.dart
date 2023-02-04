part of 'checkin_data_bloc.dart';

abstract class CheckinDataEvent extends Equatable {
  const CheckinDataEvent();

  @override
  List<Object> get props => [];
}

@immutable
class CheckinDataEventLoad extends CheckinDataEvent {
  const CheckinDataEventLoad();
}
