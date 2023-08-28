import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WALoading extends StatelessWidget {
  const WALoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox.square(
          dimension: 80,
          child: Lottie.asset(
            'assets/sun_loading.json',
            repeat: true,
          ),
        ),
      ],
    );
  }
}
