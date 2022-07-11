import 'package:cafe_news/config/icons_and_images.dart';
import 'package:cafe_news/config/stylesheet.dart';
import 'package:cafe_news/helpers/helper_functions.dart';
import 'package:cafe_news/screens/home/homepage.dart';
import 'package:cafe_news/screens/news_section/live_news.dart';
import 'package:cafe_news/screens/profile_and_settings/user_panel.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  int pageIndex;
  BottomNavigationBarScreen({Key? key, this.pageIndex = 0}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final List<Widget> _screens = [
    const HomePageScreen(),
    const HomePageScreen(),
    const HomePageScreen(),
    const UserPanelScreen(),
  ];
  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    setIndex();
  }

  setIndex() {
    setState(() => _pageIndex = widget.pageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: whiteColor,
          onPressed: () => pushTo(const LiveNewsScreen(), context),
          label: Image.asset(
            liveButton,
            width: 80,
          )),
      body: _screens[_pageIndex],
      backgroundColor: whiteColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: GNav(
            onTabChange: (value) => setState(() => _pageIndex = value),
            rippleColor: defaultColor,
            haptic: true,
            tabBorderRadius: 15,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 600),
            gap: 8,
            color: blackColor.withOpacity(0.2),
            activeColor: defaultColor, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor:
                defaultColor.withOpacity(0.1), // selected tab background color
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 5), // navigation bar padding
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.list,
                text: 'Category',
              ),
              GButton(
                icon: Icons.account_circle_rounded,
                text: 'Profile',
              )
            ]),
      ),
    );
  }
}
