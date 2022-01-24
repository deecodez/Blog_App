import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount? get user => _user;

  Future googleLogin(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      // Navigator.pop(context);
      _user = googleUser;
      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();
      // Navigator.pop(context);
    } catch (e) {
      print(e);
      return null;
    }
    Navigator.pop(context);
  }

  Future logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
    // final googleUser = await googleSignIn.signIn();
    // if (user!.displayName == null) {
    //   await googleSignIn.disconnect();
    //   FirebaseAuth.instance.signOut();
    // } else {
    //   FirebaseAuth.instance.signOut();
    // }
    // await googleSignIn.disconnect();
    // FirebaseAuth.instance.signOut();
  }
}
