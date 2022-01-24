import 'package:blog_app/provider/google_sign_in.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/bottom_bar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // static final navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () {
          return ChangeNotifierProvider(
              create: (context) => GoogleSignInProvider(),
              child: MaterialApp(
                // navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'Blog App',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    fontFamily: 'Inter',
                    textTheme: GoogleFonts.interTextTheme(
                      Theme.of(context).textTheme,
                    )),
                home: const Auth(),
              ));
        });
  }
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.hasData) {
              return const BottomBarScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
