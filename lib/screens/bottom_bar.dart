import 'package:blog_app/const/app_icon.dart';
import 'package:blog_app/const/colors.dart';
import 'package:blog_app/screens/home_screen.dart';
import 'package:blog_app/screens/profile_screen.dart';
import 'package:blog_app/screens/saved_item_screen.dart';
import 'package:blog_app/screens/search_screen.dart';
import 'package:flutter/material.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  List? _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': const HomeScreen(), 'title': 'Home'},
      {'page': const SearchScreen(), 'title': 'Feed'},
      {'page': const SavedItemScreen(), 'title': 'Search'},
      {'page': const ProfileScreen(), 'title': 'Cart'},
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages![_selectedIndex]['page'],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 3,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: const Color(0xFF99A0AC),
          elevation: 15,
          iconSize: 18,
          onTap: _selectedPage,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              tooltip: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              tooltip: 'Search',
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              activeIcon: null,
              label: '',
              tooltip: '',
              icon: Icon(null),
            ),
            BottomNavigationBarItem(
              label: 'Saved ',
              tooltip: 'Saved ',
              icon: Icon(Icons.bookmark),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              tooltip: 'Profile',
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        // tooltip: 'Search',
        elevation: 5,
        child: (const Icon(Icons.add)),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    );
  }
}
