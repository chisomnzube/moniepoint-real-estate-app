import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:real_estate_app/components/custom_buttom_nav_bar.dart';
import 'package:real_estate_app/utils/enums.dart';
import 'components/body.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Color(0xFFF9EEE2),
        elevation: 0,
        toolbarHeight: 0,
      ),
      // backgroundColor: Colors.transparent,
      // extendBodyBehindAppBar: true,
      // extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFFF9EEE2),
                  Color(0xFFFAD9B2),
                ],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Body(),
            ),
          ),
          Positioned(
            bottom: 10, // You can control this!
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              selectedMenu: MenuState.home,
              animate: true,
            ),
          ),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
