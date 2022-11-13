import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'member_info_event.dart';
part 'member_info_state.dart';

class MemberInfoBloc extends Bloc<MemberInfoEvent, MemberInfoState> {
  MemberInfoBloc(
      {required String name,
      required String tshirtSize,
      required String membershipNumber})
      : super(MemberInfoInitial(
            name: name,
            tshirtSize: tshirtSize,
            membershipNumber: membershipNumber)) {
    on<MemberInfoChangeRequested>(_onMemberInfoChangeRequested);
    on<MemberInfoNameChanged>(_onMemberInfoNameChanged);
    on<MemberInfoTshirtSizeChanged>(_onMemberInfoTshirtSizeChanged);
    on<MemberInfoMembershipNumberChanged>(_onMemberInfoMembershipNumberChanged);
    on<MemberInfoSubmitted>(_onMemberInfoSubmitted);
  }

  void _onMemberInfoChangeRequested(
    MemberInfoChangeRequested event,
    Emitter<MemberInfoState> emit,
  ) {
    emit(MemberInfoEditable(
        state.name, state.tshirtSize, state.membershipNumber));
  }

  void _onMemberInfoNameChanged(
    MemberInfoNameChanged event,
    Emitter emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onMemberInfoTshirtSizeChanged(
    MemberInfoTshirtSizeChanged event,
    Emitter<MemberInfoState> emit,
  ) {
    emit(state.copyWith(tshirtSize: event.tshirtSize));
  }

  void _onMemberInfoMembershipNumberChanged(
    MemberInfoMembershipNumberChanged event,
    Emitter<MemberInfoState> emit,
  ) {
    emit(state.copyWith(membershipNumber: event.membershipNumber));
  }

  void _onMemberInfoSubmitted(
    MemberInfoSubmitted event,
    Emitter<MemberInfoState> emit,
  ) {
    emit(MemberInfoReadonly(
        state.name, state.tshirtSize, state.membershipNumber));
  }
}
