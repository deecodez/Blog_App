import 'package:blog_app/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'all_category_content.dart';

class NewsCategoryTabBar extends StatefulWidget {
  const NewsCategoryTabBar({
    Key? key,
    // required this.children,
    // required this.tabOneText,
    // required this.tabTwoText,
    // required this.tabThreeText,
  }) : super(key: key);
  // final List<Widget> children;
  // final String tabOneText;
  // final String tabTwoText;
  // final String tabThreeText;

  @override
  _NewsCategoryTabBarState createState() => _NewsCategoryTabBarState();
}

class _NewsCategoryTabBarState extends State<NewsCategoryTabBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Container(
          //   height: 50.0.h,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(5),
          //     color: const Color(0xffe8e8e8),
          //   ),
          // ),
          Column(
            children: [
              Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                child: PreferredSize(
                  preferredSize: const Size.fromHeight(10.0),
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    labelColor: AppColor.primaryColor,
                    unselectedLabelColor: const Color(0xFF939393),
                    labelPadding: const EdgeInsets.all(5),
                    labelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Inter",
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 14.sp,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                    ),
                    // automaticIndicatorColorAdjustment: false,
                    indicatorColor: AppColor.primaryColor,
                    //TODO: To see how to customize the dot on active
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        color: AppColor.primaryColor,
                        width: 3,
                      ),
                      insets: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 40.0),
                    ),
                    // labelPadding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    // indicator: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(6),
                    //   color: AppColor.secondaryColor,
                    // ),
                    tabs: const [
                      Tab(
                        child: Text(
                          'All',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Information',
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Media",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Sports",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Business",
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Culture",
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.30.h,
                child: TabBarView(controller: _tabController, children: const [
                  AllCategoryContent(),
                  Text("Information"),
                  Text("Media"),
                  Text("Sports"),
                  Text("Business"),
                  Text("Culture"),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
























// import 'package:flutter/material.dart';

// class NewsCategoryTabBar extends StatefulWidget {
//   const NewsCategoryTabBar({Key? key}) : super(key: key);

//   @override
//   _NewsCategoryTabBarState createState() => _NewsCategoryTabBarState();
// }

// class _NewsCategoryTabBarState extends State<NewsCategoryTabBar> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 6,
//       child: 
//       Scaffold(
//           appBar: AppBar(
//             centerTitle: true,
//             // leading: Icon(Icons.person_outline),
//             // title: Text('DASHBOARD',style: TextStyle(fontSize: 16.0),),
//             bottom: PreferredSize(
//                 child: TabBar(
//                     isScrollable: true,
//                     unselectedLabelColor: Colors.white.withOpacity(0.3),
//                     indicatorColor: Colors.white,
//                     tabs: [
//                       Tab(
//                         child: Text('Tab 1'),
//                       ),
//                       Tab(
//                         child: Text('Investment'),
//                       ),
//                       Tab(
//                         child: Text('Your Earning'),
//                       ),
//                       Tab(
//                         child: Text('Current Balance'),
//                       ),
//                       Tab(
//                         child: Text('Tab 5'),
//                       ),
//                       Tab(
//                         child: Text('Tab 6'),
//                       )
//                     ]),
//                 preferredSize: Size.fromHeight(30.0)),
//             actions: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(Icons.add_alert),
//               ),
//             ],
//           ),
//           body: TabBarView(
//             children: <Widget>[
//               Container(
//                 child: Center(
//                   child: Text('Tab 1'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 2'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 3'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 4'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 5'),
//                 ),
//               ),
//               Container(
//                 child: Center(
//                   child: Text('Tab 6'),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
