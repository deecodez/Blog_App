import 'package:blog_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateBlogScreen extends StatelessWidget {
  const CreateBlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leadingWidth: 250,
        toolbarHeight: 50,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, top: 16.0),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ),
        title: Text(
          'Create post',
          style: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: const Color(0xFF0A1330),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0, top: 16.0),
            child: Text(
              'Save',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
        child: Column(
          children: [
            Container(
              height: 132.h,
              width: 327.w,
              decoration: const BoxDecoration(color: Color(0xFFEFEFEF)),
              child: const Center(
                child: CircleAvatar(child: Icon(Icons.camera_alt)),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              cursorColor: const Color(0xFF86828D),
              maxLines: 2,
              // controller: email,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF86828D)),
                ),
                isDense: true,
                // floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: "Title:",
                contentPadding: EdgeInsets.symmetric(vertical: -3.h),
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF86828D),
                ),
              ),
              onChanged: (val) {},
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'email is required';
                }
                if (!RegExp(
                        "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                    .hasMatch(value)) {
                  return 'Please input a valid email address';
                }

                // validator has to return something :)
                return null;
              },
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
          ],
        ),
      ),
    );
  }
}
