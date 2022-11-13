part of 'member_info_bloc.dart';

class MemberInfoState extends Equatable {
  const MemberInfoState({
    required this.editable,
    required this.name,
    required this.tshirtSize,
    required this.membershipNumber,
  });

  final bool editable;
  final String name;
  final String tshirtSize;
  final String membershipNumber;

  String get membershipText {
    return '$tshirtSize Membership No: $membershipNumber';
  }

  MemberInfoState copyWith({
    bool? editable,
    String? name,
    String? tshirtSize,
    String? membershipNumber,
  }) {
    return MemberInfoState(
      editable: editable ?? this.editable,
      name: name ?? this.name,
      tshirtSize: tshirtSize ?? this.tshirtSize,
      membershipNumber: membershipNumber ?? this.membershipNumber,
    );
  }

  @override
  List<Object> get props => [editable, tshirtSize, membershipNumber];
}

class MemberInfoEditable extends MemberInfoState {
  const MemberInfoEditable(name, tshirtSize, membershipNumber)
      : super(
          editable: true,
          name: name,
          tshirtSize: tshirtSize,
          membershipNumber: membershipNumber,
        );
}

class MemberInfoReadonly extends MemberInfoState {
  const MemberInfoReadonly(name, tshirtSize, membershipNumber)
      : super(
          editable: false,
          name: name,
          tshirtSize: tshirtSize,
          membershipNumber: membershipNumber,
        );
}

class MemberInfoInitial extends MemberInfoState {
  const MemberInfoInitial({name, tshirtSize, membershipNumber})
      : super(
            editable: false,
            name: name,
            tshirtSize: tshirtSize,
            membershipNumber: membershipNumber);
}
