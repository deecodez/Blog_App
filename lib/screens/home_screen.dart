import 'package:blog_app/const/colors.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 74),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Hello Sonia',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: const Color(0xFF0A1330),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Image.asset('assets/images/hand.png')
                  ],
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/profile_pic.png'),
                ),
              ],
            ),
            const SizedBox(height: 33.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 270.w,
                  child: const CustomTextFormField(
                      hintText: 'Search', preffixIcon: Icons.search),
                ),
                Container(
                  height: 44.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.slidersH,
                      color: Colors.white,
                      // size: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
