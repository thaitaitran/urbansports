import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'member_info/member_info.dart';
import 'studio_info/studio_info.dart';
import 'timer/timer.dart';

void main() {
  runApp(const App());
}

class App extends MaterialApp {
  const App({super.key}) : super(home: const CheckInPage());
}

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  final name = 'Hai Dang Bui';
  final tShirtSize = 'M';
  final membershipNumber = '529249000';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TimerCubit(ticker: const Ticker())..startTimer(),
        ),
        BlocProvider(
            create: (_) => MemberInfoBloc(
                name: name,
                tshirtSize: tShirtSize,
                membershipNumber: membershipNumber)),
      ],
      child: BlocListener<MemberInfoBloc, MemberInfoState>(
        listener: (context, state) {
          if (state.editable) {
            showDialog<void>(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.watch<MemberInfoBloc>(),
                  child: const MemberInfoDialog(),
                );
              },
            );
          }
          if (!state.editable) {
            Navigator.of(context).pop();
          }
        },
        child: const CheckInView(),
      ),
    );
  }
}

class MemberInfoDialog extends StatelessWidget {
  const MemberInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final memberInfoState = context.watch<MemberInfoBloc>().state;

    return AlertDialog(
      title: const Text('Configure Member Data'),
      content: Row(
        children: <Widget>[
          Expanded(
              child: DropdownButton(
            value: memberInfoState.tshirtSize,
            items: const [
              DropdownMenuItem(value: "S", child: Text("S")),
              DropdownMenuItem(value: "M", child: Text("M")),
              DropdownMenuItem(value: "L", child: Text("L")),
              DropdownMenuItem(value: "XL", child: Text("XL")),
            ],
            onChanged: (value) {
              context
                  .read<MemberInfoBloc>()
                  .add(MemberInfoMembershipNumberChanged(value!));
            },
          )),
          Expanded(
            child: TextField(
              onChanged: (value) {},
              //controller: _numberFieldController,
              decoration: const InputDecoration(hintText: "Membership Number"),
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
            context.read<MemberInfoBloc>().add(const MemberInfoSubmitted());
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Submit'),
          onPressed: () {
            context.read<MemberInfoBloc>().add(const MemberInfoSubmitted());
          },
        ),
      ],
    );
  }
}

/*
class _CheckInViewState extends State<CheckInView> {
  String name = "Hai Dang Bui";
  String membershipText = "M Membership No: 529249000";
  String dialogName = "";
  String dialogMembershipType = "M";
  String dialogMembershipNumber = "529249000";

  late TextEditingController _nameFieldController;
  late TextEditingController _numberFieldController;

  @override
  void initState() {
    super.initState();
    _nameFieldController = TextEditingController(text: dialogName);
    _numberFieldController =
        TextEditingController(text: dialogMembershipNumber);
  }

  // Short Dialog enabling textmodification
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      dialogName = value;
                    });
                  },
                  controller: _nameFieldController,
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: DropdownButton(
                            value: dialogMembershipType,
                            items: const [
                              DropdownMenuItem(value: "S", child: Text("S")),
                              DropdownMenuItem(value: "M", child: Text("M")),
                              DropdownMenuItem(value: "L", child: Text("L")),
                              DropdownMenuItem(value: "XL", child: Text("XL")),
                            ],
                            onChanged: (value) {
                              setState(() {
                                dialogMembershipType = value!;
                              });
                            })),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            dialogMembershipNumber = value;
                          });
                        },
                        controller: _numberFieldController,
                        decoration: const InputDecoration(
                            hintText: "Membership Number"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    setState(() {
                      name = dialogName;
                      membershipText =
                          "$dialogMembershipType Membership No: $dialogMembershipNumber";
                      Navigator.pop(context);
                    });
                  },
                ),
              )
            ],
          );
        });
  }
*/

class CheckInView extends StatelessWidget {
  const CheckInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: const Color.fromRGBO(107, 188, 135, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<TimerCubit, TimerState>(
                    builder: (context, state) {
                      return Timer(seconds: state.checkedInSeconds);
                    },
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  const MemberInfo(),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                children: const [
                  FitnessInfo(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(
                      thickness: 1.2,
                      color: Color.fromRGBO(240, 240, 240, 1),
                    ),
                  ),
                  ShareCheckInButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShareCheckInButton extends StatelessWidget {
  const ShareCheckInButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            fixedSize: const Size(double.maxFinite, 45),
            side: const BorderSide(color: Color.fromARGB(255, 35, 116, 209))),
        onPressed: () => context.read<TimerCubit>().startTimer(),
        child: const Text(
          'Share this check-in',
          style:
              TextStyle(color: Color.fromARGB(255, 35, 116, 209), fontSize: 17),
        ));
  }
}
