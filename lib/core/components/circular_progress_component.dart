import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  const CircularProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: Colors.orangeAccent,
        ),
      ),
    );
  }
}
