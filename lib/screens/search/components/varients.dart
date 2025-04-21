import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchVarient extends StatefulWidget {
  const SearchVarient({super.key});

  @override
  State<SearchVarient> createState() => _SearchVarientState();
}

class _SearchVarientState extends State<SearchVarient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward(); // Start the zoom-in animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color(0XFF747474),
        ),
        child: Row(
          children: [
            Icon(
              Icons.format_align_left_sharp,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              "List of variants",
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
