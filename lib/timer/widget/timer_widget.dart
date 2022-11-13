import 'package:flutter/material.dart';

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
