import 'package:blog_app/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: GestureDetector(
            onTap: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              // if (user.displayName == null) {
              //   FirebaseAuth.instance.signOut();
              // } else {
              //   final provider =
              //       Provider.of<GoogleSignInProvider>(context, listen: false);
              //   provider.logout();
              // }
              // user.displayName == null ? FirebaseAuth.instance.signOut(); :
            },
            child: const Text('Log Out')),
      )),
    );
  }
}
