// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_svg/svg.dart';

class WAError extends StatelessWidget {
  const WAError({
    this.onRefresh,
    super.key,
  });

  final VoidCallback? onRefresh;

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
        if (onRefresh != null) ...[
          const SizedBox(height: 8),
          IconButton(
            onPressed: onRefresh,
            icon: const Icon(
              Icons.refresh,
              size: 48,
            ),
            color: Colors.white,
          ),
        ],
      ],
    );
  }
}
