import 'package:blog_app/components/tab_bar/all_category_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleBlogDetailsScreen extends StatelessWidget {
  final String img;
  final String text;
  const SingleBlogDetailsScreen(
      {required this.img, required this.text, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Details',
          style: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: const Color(0xFF0A1330),
          ),
        ),
        leading: AppBarIcon(
          icon: Icons.arrow_back_ios,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          AppBarIcon(
            icon: Icons.more_horiz,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0),
        children: [
          Image.asset(img),
          SizedBox(height: 18.h),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: const Color(0xFF333333),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const BlogSubContent(
                icon: Icons.thumb_up_sharp,
                text: '2.2k',
              ),
              SizedBox(width: 18.w),
              const BlogSubContent(
                icon: Icons.comment,
                text: '2.2k',
              ),
              SizedBox(width: 18.w),
              const BlogSubContent(
                icon: Icons.calendar_today_outlined,
                text: '12 Jan 2021',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AppBarIcon extends StatelessWidget {
  final IconData icon;
  final void Function()? onTap;
  const AppBarIcon({
    required this.icon,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: 20.w,
        // height: 20.h,
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              // rgba(130, 130, 130, 0.19);
              color: Color.fromRGBO(130, 130, 130, 0.19),
              // spreadRadius: 5,
              blurRadius: 10,
              // offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(
            icon,
            color: const Color(0xFF0A1330),
            size: 20.0,
          ),
        ),
      ),
    );
  }
}
