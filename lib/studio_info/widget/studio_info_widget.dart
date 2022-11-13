import 'package:flutter/material.dart';
import '../../timer/bloc/timer_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import './studio_img_widget.dart';
import './icon_tile_widget.dart';

class FitnessInfo extends StatelessWidget {
  const FitnessInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const StudioImg(),
          const SizedBox(
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
