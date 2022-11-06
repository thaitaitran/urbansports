import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_sports/timer/timer_cubit.dart';
import 'package:intl/intl.dart';
import './timer/ticker.dart';

void main() {
  runApp(const App());
}

class App extends MaterialApp {
  const App({super.key}) : super(home: const CheckInPage());
}

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerCubit(ticker: const Ticker()),
      child: const CheckInView(),
    );
  }
}

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
                  const Text(
                    'Hai Dang Bui',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Calibri'),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  const Text(
                    'M Membership No: 529249000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  )
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
                children: [
                  IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        StudioImg(),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: FitnessInfo(),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(
                      thickness: 1.2,
                      color: Color.fromRGBO(240, 240, 240, 1),
                    ),
                  ),
                  OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          fixedSize: const Size(double.maxFinite, 45),
                          side: const BorderSide(
                              color: Color.fromARGB(255, 35, 116, 209))),
                      onPressed: () => context.read<TimerCubit>().startTimer(),
                      child: const Text(
                        'Share this check-in',
                        style: TextStyle(
                            color: Color.fromARGB(255, 35, 116, 209),
                            fontSize: 17),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Timer extends StatelessWidget {
  const Timer({
    required this.seconds,
    Key? key,
  }) : super(key: key);

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final minutesStr = ((seconds / 60) % 60).floor().toString().padLeft(2, '0');
    final secondStr = (seconds % 60).floor().toString().padLeft(2, '0');

    return Text(
      'Checked in: $minutesStr:$secondStr minutes ago',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
    );
  }
}

class StudioImg extends StatelessWidget {
  const StudioImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Image.asset(
        'assets/img/fitnessfirst.png',
        fit: BoxFit.cover,
      ),
    );
  }
}

class FitnessInfo extends StatelessWidget {
  const FitnessInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Fitness',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15.0,
          ),
        ),
        BlocBuilder<TimerCubit, TimerState>(
          builder: (context, state) {
            return Text(DateFormat('dd MMM, kk:mm').format(state.checkIn));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconTile(
              icon: Icons.room,
              text: 'Crunch Fit Berlin-Wedding',
              iconColor: Color.fromRGBO(155, 155, 155, 1),
            ),
            Spacer(),
            Text(
              '(Wedding)',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        const IconTile(
          icon: Icons.sell,
          text: 'Fitness',
        ),
      ],
    );
  }
}

class IconTile extends StatelessWidget {
  const IconTile({
    super.key,
    required this.icon,
    this.iconColor,
    required this.text,
  });

  final IconData icon;
  final Color? iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: iconColor ?? const Color.fromRGBO(77, 77, 77, 1),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
