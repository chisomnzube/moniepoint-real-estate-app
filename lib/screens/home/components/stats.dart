import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constants.dart';

class HomeStats extends StatelessWidget {
  const HomeStats({super.key});

  @override
  Widget build(BuildContext context) {
    final double statSize = MediaQuery.of(context).size.width * 0.4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // BUY Section
        Container(
          width: statSize,
          height: statSize,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("BUY", style: TextStyle(color: Colors.white)),
                SizedBox(height: 25),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1034),
                  duration: Duration(seconds: 2),
                  builder: (context, value, child) => Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Text("offers", style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),

        // RENT Section
        Container(
          width: statSize,
          height: statSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "RENT",
                  style: TextStyle(color: SemiBlack),
                ),
                SizedBox(height: 25),
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 2212),
                  duration: Duration(seconds: 2),
                  builder: (context, value, child) => Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: SemiBlack,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                Text("offers", style: TextStyle(color: SemiBlack)),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
