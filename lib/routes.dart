import 'package:my_first_app/about/about.dart';
import 'package:my_first_app/profile/profile.dart';
import 'package:my_first_app/login/login.dart';
import 'package:my_first_app/topics/topics.dart';
import 'package:my_first_app/home/home.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/about': (context) => const AboutScreen(),
};
