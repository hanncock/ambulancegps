import 'package:flutter/material.dart';

class LoadingSpinCircle extends StatelessWidget {
  const LoadingSpinCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.redAccent,
      ),
    );
  }
}