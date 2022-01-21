import 'package:blog_app/const/colors.dart';
import 'package:blog_app/const/text_syle.dart';
import 'package:blog_app/components/tab_bar/news_category_tab_bar.dart';
import 'package:blog_app/screens/login_screen.dart';
import 'package:blog_app/screens/single_blog_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 14.0),
          child: Row(
            children: [
              const Text(
                'Hello Sonia',
                style: TextStyling.headingStyle,
              ),
              const SizedBox(width: 8.0),
              Image.asset('assets/images/hand.png')
            ],
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile_pic.png'),
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
                    hintText: 'Search', preffixIcon: Icons.search),
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
          BlogGrid(),
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
  final String datePosted;
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
      // height: 300.h,
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
          Image.asset(
            blogImg,
            width: double.infinity,
            // height: 150.h,
          ),
          const SizedBox(height: 14.0),
          Container(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
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
                          backgroundImage: AssetImage(
                            authorImg,
                          ),
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
                          datePosted,
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
  BlogGrid({Key? key}) : super(key: key);
  final List<BlogDetails> blogDetails = [
    BlogDetails(
      blogImg: 'assets/images/blog_image.png',
      blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
      authorImg: 'assets/images/profile_pic.png',
      authorName: 'John Stone',
      datePosted: '12 Jan 2021',
    ),
    BlogDetails(
      blogImg: 'assets/images/blog_image.png',
      blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
      authorImg: 'assets/images/profile_pic.png',
      authorName: 'John Stone',
      datePosted: '12 Jan 2021',
    ),
    BlogDetails(
      blogImg: 'assets/images/blog_image.png',
      blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
      authorImg: 'assets/images/profile_pic.png',
      authorName: 'John Stone',
      datePosted: '12 Jan 2021',
    ),
    BlogDetails(
      blogImg: 'assets/images/blog_image.png',
      blogTitle: 'Twinku raises \$4.2m seed for Africa-wide expansion',
      authorImg: 'assets/images/profile_pic.png',
      authorName: 'John Stone',
      datePosted: '12 Jan 2021',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: blogDetails.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 260.w,
          childAspectRatio: 1,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (context, int index) {
          final blog = blogDetails[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return SingleBlogDetailsScreen(
                  img: blog.blogImg,
                  text: blog.blogTitle,
                );
              }));
            },
            child: BlogContainer(
              blogImg: blog.blogImg,
              blogTitle: blog.blogTitle,
              authorImg: blog.authorImg,
              authorName: blog.authorName,
              datePosted: blog.datePosted,
            ),
          );
        },
      ),
    );
  }
}
