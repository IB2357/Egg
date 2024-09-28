import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_first_app/services/services.dart';
import 'package:my_first_app/shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var report = Provider.of<Report>(context);
    var user = AuthService().user;

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(user.displayName ?? 'Guest'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(fit: BoxFit.cover,
                    image: NetworkImage(user.photoURL ??
                        'https://avatar.iran.liara.run/public'),
                  ),
                ),
              ),
              Text(user.email ?? '',
                  style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Text('${report.total}',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('Quizzes Completed',
                  style: Theme.of(context).textTheme.titleSmall),
              const Spacer(),
              ElevatedButton(
                child: const Text('logout'),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    } else {
      return const Loader();
    }
  }
}
