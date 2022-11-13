import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/member_info_bloc.dart';

class MemberInfo extends StatelessWidget {
  const MemberInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        context.read<MemberInfoBloc>().add(const MemberInfoChangeRequested());
      },
      child: BlocBuilder<MemberInfoBloc, MemberInfoState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                state.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                state.membershipText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
