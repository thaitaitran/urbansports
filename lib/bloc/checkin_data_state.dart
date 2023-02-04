part of 'checkin_data_bloc.dart';

class CheckinDataState extends Equatable {
  final String url;

  const CheckinDataState.empty() : url = '';

  const CheckinDataState({
    required this.url,
  });

  @override
  List<Object> get props => [url];
}

//class CheckinDataInitial extends CheckinDataState {}
