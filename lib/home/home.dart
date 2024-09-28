import 'package:flutter/material.dart';
import 'package:my_first_app/login/login.dart';
import 'package:my_first_app/services/auth.dart';
import 'package:my_first_app/shared/shared.dart';
import 'package:my_first_app/topics/topics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return const TopicsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
