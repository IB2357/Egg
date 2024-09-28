import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'About:',
            style: TextStyle(fontSize: 50, height: 2),
          ),
          Text(
              '  This is my first Flutter app \nUnlike me I hope you enjoy it.'),
        ],
      )),
    );
  }
}
