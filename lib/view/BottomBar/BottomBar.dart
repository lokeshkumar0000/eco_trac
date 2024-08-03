import 'dart:developer';
import 'dart:io';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:electricity/view/Home/home.dart';
import 'package:electricity/view/customer_support/Customer_Support.dart';
import 'package:electricity/view/profile/Profile_Page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});


  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  /// Controller to handle PageView and also handles initial page
  final _pageController = PageController(initialPage: 1);

  /// Controller to handle bottom nav bar and also handles initial page
  final _controller = NotchBottomBarController(index: 1);

  int maxCount = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// widget list
  final List<Widget> bottomBarPages = [
    ProfilePage(),
    HomePage(userName: "Sanjeev"),
     CustomerSupportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
            bottomBarPages.length, (index) => bottomBarPages[index]),
      ),
      extendBody: true,
    
      bottomNavigationBar: (bottomBarPages.length <= maxCount)
          ? AnimatedNotchBottomBar(
            
            showBlurBottomBar: false,
            showShadow: true,
              /// Provide NotchBottomBarController
              notchBottomBarController: _controller,
              color: Colors.white,
              showLabel: true,
              notchColor: Colors.black87,

              /// restart app if you change removeMargins
              removeMargins: false,
              bottomBarWidth: 100,
              
              durationInMilliSeconds: 300,
              bottomBarItems: const [
                BottomBarItem(
              
                  inActiveItem: Icon(
                    Icons.person,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  itemLabel: 'Profile',
                ),

                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.home_filled,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.home_filled,
                    color: Colors.white,
                  ),
                  itemLabel: 'Home',
                ),
                BottomBarItem(
                  inActiveItem: Icon(
                    Icons.headphones,
                    color: Colors.blueGrey,
                  ),
                  activeItem: Icon(
                    Icons.headset_mic,
                    color: Colors.white,
                  ),
                  itemLabel: 'Support',
                ),

                ///svg example
              ],
              onTap: (index) {
                /// perform action on tab change and to update pages you can update pages without pages
                log('current selected index $index');
                _pageController.jumpToPage(index);
              },
            )
          : null,
    );
  }
}


