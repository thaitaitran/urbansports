import 'package:flutter/material.dart';

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
