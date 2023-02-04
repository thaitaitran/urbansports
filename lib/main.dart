import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urban_sports/timer/timer_cubit.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import './timer/ticker.dart';
import 'bloc/checkin_data_bloc.dart';

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
      create: (_) => TimerCubit(ticker: const Ticker())..startTimer(),
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
                child: MemberInfo()),
          ),
          Container(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.all(15.0),
              color: Colors.white,
              child: Column(
                children: [
                  StudioInfo(),
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

class MemberInfo extends StatefulWidget {
  const MemberInfo({super.key});

  @override
  State<MemberInfo> createState() => _MemberInfoState();
}

class _MemberInfoState extends State<MemberInfo> {
  // QR Reader
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckinDataBloc(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 2,
              ),
            ),
            child: Center(
                child: BlocConsumer(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return result == null
                          ? QRView(
                              key: qrKey,
                              onQRViewCreated: _onQRViewCreated,
                            )
                          : Text(state?.url); //TODO: WHY STATE NOT WORKING
                      //BLOC SEEMS UGLY AF, WILL DO https://pub.dev/packages/cubes
                    })),
          ),
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
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        isLoading = true;
        result = scanData;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class StudioInfo extends StatefulWidget {
  const StudioInfo({super.key});

  @override
  State<StudioInfo> createState() => _StudioInfoState();
}

class _StudioInfoState extends State<StudioInfo> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Image.asset(
              'assets/img/fitnessfirst.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
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
                BlocSelector<TimerCubit, TimerState, DateTime>(
                  selector: (state) => state.checkIn,
                  builder: (context, checkIn) {
                    return Text(DateFormat('dd MMM, kk:mm').format(checkIn));
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
            ),
          ),
        ],
      ),
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
