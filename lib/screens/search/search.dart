import 'package:flutter/material.dart';
import 'package:real_estate_app/components/custom_buttom_nav_bar.dart';
import 'package:real_estate_app/utils/enums.dart';
import 'components/body.dart';
import 'components/header.dart';
import 'components/varients.dart';
import 'components/tab.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      body: Stack(
        children: [
          Body(), // <- this will show the Google Map full screen
          Positioned(
            top: 40,
            left: 0,
            right: 0,
            child: SearchHeader(),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              selectedMenu: MenuState.search,
              animate: false,
            ),
          ),
          Positioned(
            bottom: 150, // Adjust as needed to stay above the nav bar
            right: 10,
            child: SearchVarient(),
          ),
          Positioned(
            bottom: 150, // Adjust as needed to stay above the nav bar
            left: 10,
            child: SearchTab(),
          ),
        ],
      ),

      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
