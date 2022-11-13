part of 'member_info_bloc.dart';

abstract class MemberInfoEvent extends Equatable {
  const MemberInfoEvent();

  @override
  List<Object> get props => [];
}

class MemberInfoChangeRequested extends MemberInfoEvent {
  const MemberInfoChangeRequested();
}

class MemberInfoNameChanged extends MemberInfoEvent {
  const MemberInfoNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class MemberInfoTshirtSizeChanged extends MemberInfoEvent {
  const MemberInfoTshirtSizeChanged(this.tshirtSize);

  final String tshirtSize;

  @override
  List<Object> get props => [tshirtSize];
}

class MemberInfoMembershipNumberChanged extends MemberInfoEvent {
  const MemberInfoMembershipNumberChanged(this.membershipNumber);

  final String membershipNumber;

  @override
  List<Object> get props => [membershipNumber];
}

class MemberInfoSubmitted extends MemberInfoEvent {
  const MemberInfoSubmitted();
}
