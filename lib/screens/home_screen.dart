import 'package:blog_app/const/colors.dart';
import 'package:blog_app/const/text_syle.dart';
import 'package:blog_app/components/tab_bar/news_category_tab_bar.dart';
import 'package:blog_app/models/retrive_post_model.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/single_blog_details.dart';
import 'package:blog_app/services/firebase_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    // final firstName = user.displayName!.split(" ")[0];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(
            children: [
              Text(
                user.displayName == null
                    ? user.email!
                    : 'Hello ${user.displayName!.split(" ")[0]}',
                style: TextStyling.headingStyle,
              ),
              const SizedBox(width: 8.0),
              Image.asset('assets/images/hand.png')
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: user.photoURL == null
                  ? const NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/03/27/22/16/fashion-1284496__340.jpg')
                  : NetworkImage(user.photoURL!),
            ),
          ),
        ],
      ),
      body: ListView(
        //TODO: To see how to solve the issue of padding in he grid
        padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 33.0),
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Row(
          //       children: [
          //         const Text(
          //           'Hello Sonia',
          //           style: TextStyling.headingStyle,
          //         ),
          //         const SizedBox(width: 8.0),
          //         Image.asset('assets/images/hand.png')
          //       ],
          //     ),
          //     const CircleAvatar(
          //       radius: 20,
          //       backgroundImage: AssetImage('assets/images/profile_pic.png'),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 33.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 270.w,
                child: const CustomTextFormField(
                    obscureText: false,
                    hintText: 'Search',
                    preffixIcon: Icons.search),
              ),
              Container(
                height: 44.h,
                width: 44.w,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child:
                    Center(child: Image.asset('assets/images/filter_icon.png')),
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          const Text(
            'Breaking news',
            style: TextStyling.headingStyle,
          ),
          const SizedBox(height: 18.0),
          const BlogGrid(),
          const SizedBox(height: 18.0),
          const NewsCategoryTabBar()
        ],
      ),
    );
  }
}

class BlogContainer extends StatelessWidget {
  final String blogImg;
  final String blogTitle;
  final String authorImg;
  final String authorName;
  final DateTime datePosted;
  const BlogContainer({
    required this.blogImg,
    required this.blogTitle,
    required this.authorImg,
    required this.authorName,
    required this.datePosted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 287.w,
      height: 260.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            // rgba(130, 130, 130, 0.19);
            color: Color.fromRGBO(130, 130, 130, 0.19),
            // spreadRadius: 5,
            blurRadius: 10,
            // offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(blogImg),
              ),
            ),
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogTitle,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: const Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(authorImg),
                          // AssetImage(
                          //   authorImg,
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
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_outlined,
                          size: 15.0,
                        ),
                        const SizedBox(width: 5.0),
                        Text(
                          DateFormat(' d MMM yyyy')
                              .format(datePosted)
                              .toString(),
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: const Color(0xFF7B7B7B),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BlogDetails {
  final String blogImg;
  final String blogTitle;
  final String authorImg;
  final String authorName;
  final String datePosted;

  BlogDetails({
    required this.blogImg,
    required this.blogTitle,
    required this.authorImg,
    required this.authorName,
    required this.datePosted,
  });
}

class BlogGrid extends StatelessWidget {
  const BlogGrid({Key? key}) : super(key: key);
  // final List<BlogDetails> blogDetails = [
  //   BlogDetails(
  //     blogImg: 'assets/images/blog_image.png',
  //     blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
  //     authorImg: 'assets/images/profile_pic.png',
  //     authorName: 'John Stone',
  //     datePosted: '12 Jan 2021',
  //   ),
  //   BlogDetails(
  //     blogImg: 'assets/images/blog_image.png',
  //     blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
  //     authorImg: 'assets/images/profile_pic.png',
  //     authorName: 'John Stone',
  //     datePosted: '12 Jan 2021',
  //   ),
  //   BlogDetails(
  //     blogImg: 'assets/images/blog_image.png',
  //     blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
  //     authorImg: 'assets/images/profile_pic.png',
  //     authorName: 'John Stone',
  //     datePosted: '12 Jan 2021',
  //   ),
  //   BlogDetails(
  //     blogImg: 'assets/images/blog_image.png',
  //     blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
  //     authorImg: 'assets/images/profile_pic.png',
  //     authorName: 'John Stone',
  //     datePosted: '12 Jan 2021',
  //   ),
  // ];
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder<List<Post>>(
      stream: FireBaseApi().getBlogPosts(user.uid),
      builder: (context, snapShot) {
        if (snapShot.hasError) {
          return Text(
            'Something Went wrong ${snapShot.error}',
            style: TextStyling.headingStyle,
          );
        } else if (snapShot.hasData) {
          final blogData = snapShot.data!;
          return SizedBox(
            height: 260.h,
            child: blogData.isEmpty
                ? const Text(
                    'No Post Yet, Please Add One',
                    style: TextStyling.headingStyle,
                  )
                : GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: blogData.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisExtent: 260.w,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 16.0,
                    ),
                    itemBuilder: (context, int index) {
                      final blog = blogData[index];
                      // final blog = blogDetails[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SingleBlogDetailsScreen(
                              postId: blog.postId,
                              blogImgUrl: blog.blogImgUrl,
                              title: blog.title,
                              body: blog.body,
                              authorImg: blog.authorImg,
                              authorName: blog.authorName,
                              datePosted: DateFormat(' d MMM yyyy')
                                  .format(blog.datePosted)
                                  .toString(),
                            );
                          }));
                        },
                        child: BlogContainer(
                          blogImg: blog.blogImgUrl,
                          blogTitle: blog.title,
                          authorImg: blog.authorImg,
                          authorName: blog.authorName,
                          datePosted: blog.datePosted,
                        ),
                      );
                    },
                  ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}



                // ListView.builder(
                //   scrollDirection: Axis.horizontal,
                //   m
                //   itemCount: blogData.length,
                //   itemBuilder: (context, int index) {
                //     final blog = blogData[index];
                //     return GestureDetector(
                //       onTap: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (BuildContext context) {
                //           return SingleBlogDetailsScreen(
                //             img: blog.blogImgUrl,
                //             text: blog.title,
                //           );
                //         }));
                //       },
                //       child: BlogContainer(
                //         blogImg: blog.blogImgUrl,
                //         blogTitle: blog.title,
                //         authorImg: blog.authorImg,
                //         authorName: blog.authorName,
                //         datePosted: blog.datePosted,
                //       ),
                //     );
                //   },
                // ),
