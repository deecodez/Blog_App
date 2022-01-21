import 'package:blog_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditBlogScreen extends StatelessWidget {
  const EditBlogScreen({Key? key}) : super(key: key);

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
          'Edit post',
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
              width: 507.w,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/blog_image.png'))),
              child: const Center(
                child: CircleAvatar(child: Icon(Icons.camera_alt)),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Twinku raises \$4.2m seed for Africa-wide expansion',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: const Color(0xFF3C3C3C),
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisl urna mi egestas ipsum ut lorem adipiscing nisl consectetur. Posuere ut fames feugiat tempor vitae elementum aliquam iaculis auctor. Nisi laoreet sagittis tortor, netus fermentum. Et elit purus arcu felis, diam purus lacus, felis. Facilisis quam quam adipiscing nunc ridiculus nulla proin nunc at. Ipsum augue amet neque, aliquam adipiscing. Amet parturient elementum id tellus mauris ut sed. Gravida egestas enim rhoncus pellentesque tincidunt faucibus. Nunc, diam dui arcu viverra et auctor accumsan in justo. Nunc, lectus massa potenti vulputate at tincidunt vestibulum. Elit, nisi, at ac dui. Vitae nunc, faucibus id est id. Vitae lobortis maecenas at faucibus cras.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: const Color(0xFF3C3C3C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
