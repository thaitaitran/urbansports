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
        showDialog<void>(
          context: context,
          builder: (_) {
            return BlocProvider.value(
              value: context.read<MemberInfoBloc>(),
              child: const MemberInfoDialog(),
            );
          },
        );
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

class MemberInfoDialog extends StatelessWidget {
  const MemberInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final initialTshirtSize = context.read<MemberInfoBloc>().state.tshirtSize;
    return BlocBuilder<MemberInfoBloc, MemberInfoState>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Configure Member Data'),
          content: Row(
            children: <Widget>[
              Expanded(
                  child: DropdownButton(
                value: context.read<MemberInfoBloc>().state.tshirtSize,
                items: const [
                  DropdownMenuItem(value: "S", child: Text("S")),
                  DropdownMenuItem(value: "M", child: Text("M")),
                  DropdownMenuItem(value: "L", child: Text("L")),
                  DropdownMenuItem(value: "XL", child: Text("XL")),
                ],
                onChanged: (value) {
                  context
                      .read<MemberInfoBloc>()
                      .add(MemberInfoTshirtSizeChanged(value!));
                },
              )),
              Expanded(
                child: TextField(
                  onChanged: (value) {},
                  //controller: _numberFieldController,
                  decoration:
                      const InputDecoration(hintText: "Membership Number"),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
                context
                    .read<MemberInfoBloc>()
                    .add(MemberInfoTshirtSizeChanged(initialTshirtSize));
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Submit'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
