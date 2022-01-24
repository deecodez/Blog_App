import 'package:blog_app/components/tab_bar/all_category_content.dart';
import 'package:blog_app/const/colors.dart';
import 'package:blog_app/screens/edit_blog_screen.dart';
import 'package:blog_app/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleBlogDetailsScreen extends StatelessWidget {
  final String blogImgUrl;
  final String title;
  final String body;
  final String authorImg;
  final String authorName;
  final String datePosted;
  final String postId;
  const SingleBlogDetailsScreen(
      {required this.blogImgUrl,
      required this.title,
      required this.body,
      required this.authorImg,
      required this.authorName,
      required this.datePosted,
      required this.postId,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 50.0,
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
        leading: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: AppBarIcon(
            color: Colors.white,
            icon: Icons.arrow_back_ios,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditBlogScreen()),
                );
              }
              if (value == 1) {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  builder: (ctx) => AlertDialog(
                    // title: const Text('Are you sure?'),
                    content: const Text(
                        'Are you sure you want to delete this post?'),
                    actions: [
                      SizedBox(
                        width: 130.w,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF2F2F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(ctx).pop(false);
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: const Color(0xFF363636),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              // rgba(130, 130, 130, 0.19);rgba(14, 80, 207, 0.13);
                              color: Color.fromRGBO(14, 80, 207, 0.13),
                              // spreadRadius: 5,
                              blurRadius: 10,
                              // offset: Offset(0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        width: 130.w,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF1251C4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            FireBaseApi().deletePost(postId);
                            //Displaying message
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Post Deleted Succesfully'),
                              duration: Duration(seconds: 3),
                            ));
                            Navigator.of(ctx).pop(true);
                            Navigator.of(ctx).pop(true);
                          },
                          child: Text(
                            'YES',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
            elevation: 20.0,
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(11.0),
              ),
            ),
            icon: Container(
              width: 40.w,
              height: 40.h,
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
              child: const Icon(
                Icons.more_horiz,
                color: Color(0xFF0A1330),
                size: 15.0,
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: SizedBox(
                    // padding: const EdgeInsets.only(top: 50.0),
                    width: 200.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.edit,
                          color: Color(0xFF282828),
                        ),
                        Text(
                          'Edit Post',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xFF282828),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFBDBDBD),
                        )
                      ],
                    ),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: SizedBox(
                    // padding: const EdgeInsets.only(top: 50.0),
                    width: 200.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Color(0xFFEF0404),
                        ),
                        Text(
                          'Delete Post',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xFFEF0404),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFBDBDBD),
                        )
                      ],
                    ),
                  )),
            ],
          ),
          // AppBarIcon(
          //   color: Colors.white,
          //   icon: Icons.more_horiz,
          //   onTap: () => _key.currentState.showButtonMenu(),
          // ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
        children: [
          Stack(
            clipBehavior: Clip.none,
            // fit: StackFit.expand,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 195.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(blogImgUrl),
                  ),
                ),
              ),
              // Image.asset(img),
              const Positioned(
                bottom: -15,
                left: 220,
                child: AppBarIcon(
                  icon: Icons.bookmark,
                  color: Color(0xFFF3F3F3),
                  // color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            title,
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
              BlogSubContent(
                icon: Icons.calendar_today_outlined,
                text: datePosted,
              ),
            ],
          ),
          SizedBox(height: 13.h),
          Row(
            children: [
              CircleAvatar(radius: 15, backgroundImage: NetworkImage(authorImg)
                  //  AssetImage(
                  //   'assets/images/profile_pic.png',
                  // ),
                  ),
              const SizedBox(width: 8.0),
              Text(
                authorName,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: const Color(0xFF7B7B7B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Text(
            body,
            style: TextStyle(
              fontFamily: 'Inter',
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: const Color(0xFF989BA5),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        // height: 50.h,
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 37.0),
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
        ),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Write a comment...',
              hintStyle: TextStyle(
                fontFamily: 'Inter',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                color: const Color(0xFF8A8A8A),
              ),
              suffixIcon: const Padding(
                padding: EdgeInsets.all(9.0),
                child: CircleAvatar(
                  radius: 10.0,
                  backgroundColor: Color.fromRGBO(34, 129, 227, 0.17),
                  child: Center(
                    child: Icon(
                      Icons.send,
                      color: AppColor.primaryColor,
                      size: 18.0,
                    ),
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(33.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(33.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppBarIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final void Function()? onTap;
  const AppBarIcon({
    required this.icon,
    required this.color,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              // rgba(130, 130, 130, 0.19);
              color: Color.fromRGBO(130, 130, 130, 0.19),
              // spreadRadius: 5,
              blurRadius: 10,
              // offset: Offset(0, 4), // changes position of shadow
            ),
          ],
          shape: BoxShape.circle,
          color: color,
        ),
        child: Center(
          child: Icon(
            icon,
            color: const Color(0xFF0A1330),
            size: 15.0,
          ),
        ),
      ),
    );
  }
}
