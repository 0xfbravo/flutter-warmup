import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WAError extends StatelessWidget {
  const WAError({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Center(
          child: SizedBox.square(
            dimension: 120,
            child: SvgPicture.asset(
              'assets/error.svg',
            ),
          ),
        ),
        const Text(
          'Unable to fetch data',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
