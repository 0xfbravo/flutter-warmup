// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:lottie/lottie.dart';

class WALoading extends StatelessWidget {
  const WALoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: SizedBox.square(
            dimension: 80,
            child: Lottie.asset(
              'assets/sun_loading.json',
              repeat: true,
            ),
          ),
        ),
      ],
    );
  }
}
