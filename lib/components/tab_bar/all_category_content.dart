import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCategoryContent extends StatelessWidget {
  const AllCategoryContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      child: BlogCategoryListView(),
    );
  }
}

class BlogCategoryContainer extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String noOfLike;
  final String noOfComment;
  final String datePosted;
  const BlogCategoryContainer({
    required this.imgUrl,
    required this.title,
    required this.noOfLike,
    required this.noOfComment,
    required this.datePosted,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(imgUrl),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 24.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlogSubContent(
                          icon: Icons.thumb_up_sharp,
                          text: noOfLike,
                        ),
                        BlogSubContent(
                          icon: Icons.comment,
                          text: noOfComment,
                        ),
                        BlogSubContent(
                          icon: Icons.calendar_today_outlined,
                          text: datePosted,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 28.h),
      ],
    );
  }
}

class BlogSubContent extends StatelessWidget {
  final IconData icon;
  final String text;
  const BlogSubContent({
    required this.icon,
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18.0, color: const Color(0xFF7D7D7D)),
        SizedBox(width: 6.h),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Inter',
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: const Color(0xFF7D7D7D),
          ),
        ),
      ],
    );
  }
}

class BlogCategoryDetails {
  final String imgUrl;
  final String title;
  final String noOfLike;
  final String noOfComment;
  final String datePosted;

  BlogCategoryDetails({
    required this.imgUrl,
    required this.title,
    required this.noOfLike,
    required this.noOfComment,
    required this.datePosted,
  });
}

class BlogCategoryListView extends StatelessWidget {
  BlogCategoryListView({Key? key}) : super(key: key);

  final List<BlogCategoryDetails> blogCategoryDetails = [
    BlogCategoryDetails(
      imgUrl: 'assets/images/ronaldo.png',
      title: 'Ronaldo continues goal drought after 8 games',
      noOfLike: '2.2k',
      noOfComment: '2.2k',
      datePosted: '12 Jan 2021',
    ),
    BlogCategoryDetails(
      imgUrl: 'assets/images/ronaldo.png',
      title: 'Ronaldo continues goal drought after 8 games',
      noOfLike: '2.2k',
      noOfComment: '2.2k',
      datePosted: '12 Jan 2021',
    ),
    BlogCategoryDetails(
      imgUrl: 'assets/images/ronaldo.png',
      title: 'Ronaldo continues goal drought after 8 games',
      noOfLike: '2.2k',
      noOfComment: '2.2k',
      datePosted: '12 Jan 2021',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.0,
      child: ListView.builder(
          itemCount: blogCategoryDetails.length,
          itemBuilder: (context, int index) {
            final blogItem = blogCategoryDetails[index];
            return BlogCategoryContainer(
              imgUrl: blogItem.imgUrl,
              title: blogItem.title,
              noOfLike: blogItem.noOfLike,
              noOfComment: blogItem.noOfComment,
              datePosted: blogItem.datePosted,
            );
          }),
    );
  }
}
