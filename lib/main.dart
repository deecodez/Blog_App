import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'screens/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Blog App',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'Inter',
                textTheme: GoogleFonts.interTextTheme(
                  Theme.of(context).textTheme,
                )),
            home: const BottomBarScreen(),
            // home: const LoginScreen(),
          );
        });
  }
}
