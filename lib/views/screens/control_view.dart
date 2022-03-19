import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';
import 'package:xsmoke/views/screens/prev_experience_screen.dart';
import 'package:xsmoke/views/screens/profile_screen.dart';
import 'package:xsmoke/views/screens/statistics_screen.dart';

import 'home_screen.dart';

class ControllerView extends StatefulWidget {
  @override
  State<ControllerView> createState() => _ControllerViewState();
}

class _ControllerViewState extends State<ControllerView> {
  late PageController pageController = PageController(initialPage: 0);

  int navValue = 0;

  Widget drawBottomNavigationBar() {
    return WaterDropNavBar(
      backgroundColor: Colors.black,
      onItemSelected: (index) {
        setState(() {
          navValue = index;
          pageController.animateToPage(navValue,
              duration: const Duration(milliseconds: 800),
              curve: Curves.decelerate);
        });
      },
      selectedIndex: navValue,
      waterDropColor: Colors.white,
      iconSize: 30,
      inactiveIconColor: Colors.white,
      bottomPadding: 10,
      barItems: [
        BarItem(
          filledIcon: Icons.home,
          outlinedIcon: Icons.home_outlined,
        ),
        BarItem(
          filledIcon: Icons.bar_chart,
          outlinedIcon: Icons.bar_chart_outlined,
        ),
        BarItem(
          filledIcon: Icons.volunteer_activism,
          outlinedIcon: Icons.volunteer_activism_outlined,
        ),
        BarItem(
          filledIcon: Icons.person,
          outlinedIcon: Icons.person_outlined,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: drawBottomNavigationBar(),
      body: PageView(
        controller: pageController,
        children: [
          HomeScreen(),
          StatisticsScreen(),
          PrevExperience(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
