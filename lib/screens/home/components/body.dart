import 'package:flutter/material.dart';
import './header.dart';
import './intro.dart';
import './stats.dart';
import './properties.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: 20),
            HomeIntro(),
            SizedBox(height: 20),
            HomeStats(),
            SizedBox(height: 20),
            HomeProperties(),
          ],
        ),
      ),
    );
  }
}
