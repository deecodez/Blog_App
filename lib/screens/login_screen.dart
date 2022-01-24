import 'package:blog_app/const/colors.dart';
import 'package:blog_app/const/text_syle.dart';
import 'package:blog_app/provider/google_sign_in.dart';
import 'package:blog_app/resuable-widgets/custom_button.dart';
import 'package:blog_app/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final auth = FireBaseApi();
  final navigatorKey = GlobalKey<NavigatorState>();
  bool obstureText = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100),
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 61.h),
            CustomTextFormField(
              hintText: 'Email',
              obscureText: false,
              suffixIcon: const Icon(
                Icons.email,
                color: Color(0xFF78768E),
                size: 20.0,
              ),
              controler: emailController,
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              hintText: 'Password',
              obscureText: obstureText,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    obstureText = !obstureText;
                  });
                },
                child: Icon(
                  obstureText ? Icons.visibility : Icons.visibility_off,
                  color: const Color(0xFF78768E),
                  size: 20.0,
                ),
              ),
              controler: passwordController,
            ),
            SizedBox(height: 35.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: RememberMeCheckBox(),
                ),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                    color: AppColor.primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            CustomButton(
              buttonText: 'Login',
              onPressed: () {
                auth.signIn(emailController.text.trim(),
                    passwordController.text.trim(), context);

                // navigatorKey.currentState!.popUntil((route) => route.isFirst);
              },
            ),
            SizedBox(height: 23.h),
            Text(
              'Or log in with',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: 13.sp,
                color: const Color(0xFF8E8CA3),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/apple_icon.png'),
                const SizedBox(width: 13.0),
                GestureDetector(
                    onTap: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin(context);
                    },
                    child: Image.asset('assets/images/google_icon.png')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final IconData? preffixIcon;
  final TextEditingController? controler;
  final bool? obscureText;
  const CustomTextFormField({
    required this.hintText,
    this.suffixIcon,
    this.preffixIcon,
    this.controler,
    this.obscureText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      child: TextFormField(
        controller: controler,
        cursorColor: AppColor.primaryColor,
        obscureText: obscureText!,
        decoration: InputDecoration(
          fillColor: AppColor.secondaryColor,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyling.hintTextStyle,
          suffixIcon: suffixIcon,
          prefixIcon: Icon(
            preffixIcon,
            color: const Color(0xFF78768E),
            size: 20.0,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}

class RememberMeCheckBox extends StatefulWidget {
  const RememberMeCheckBox({Key? key}) : super(key: key);

  @override
  _RememberMeCheckBoxState createState() => _RememberMeCheckBoxState();
}

class _RememberMeCheckBoxState extends State<RememberMeCheckBox> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(4.r),
        //   side: const BorderSide(
        //     color: Color(0xFFD0D5DD),
        //     width: 1.0,
        //   ),
        // ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        controlAffinity: ListTileControlAffinity.leading,
        value: checked,
        // title: Transform.translate(offset: Offset(-15,0),
        title: Transform.translate(
          offset: const Offset(-17, 0),
          child: Text(
            'Remember me',
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFF344054),
            ),
          ),
        ),
        onChanged: (newValue) {
          setState(() {
            checked = newValue!;
          });
        });
  }
}
