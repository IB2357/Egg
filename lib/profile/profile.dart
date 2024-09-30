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
                  image: DecorationImage(
                    fit: BoxFit.cover,
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
                child: const Text('Logout'),
                onPressed: () async {
                  await AuthService().signOut();
                  if (mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  }
                },
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text('Reset Progress'),
                onPressed: () async {
                  bool confirm = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Reset Progress'),
                        content: const Text(
                            'Are you sure you want to reset your progress? This action cannot be undone.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); 
                            },
                          ),
                          TextButton(
                            child: const Text('Reset'),
                            onPressed: () {
                              Navigator.of(context).pop(
                                  true); 
                            },
                          ),
                        ],
                      );
                    },
                  );
                  if (confirm == true) {
                    FirestoreService().resetUserReport();
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
