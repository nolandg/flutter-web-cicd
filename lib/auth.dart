import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void initAuth() {
  GoogleAuthProvider googleProvider = GoogleAuthProvider();

  googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
  googleProvider.setCustomParameters({});
}

class AuthStatus extends StatelessWidget {
  const AuthStatus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(children: [
            const Text('You\'re signed in as:'),
            Text(
              '${snapshot.data!.email}',
              key: const Key('auth:user-email'),
              style: Theme.of(context).textTheme.headlineSmall,
            )
          ]);
        } else {
          return const Text('You\'re not signed in :-(');
        }
      },
    );
  }
}
