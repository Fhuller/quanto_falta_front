import 'package:flutter/material.dart';

class QuantoLogo extends StatelessWidget {
  const QuantoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          height: 150,
        ),
        const Text(
          'Quanto Falta',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
