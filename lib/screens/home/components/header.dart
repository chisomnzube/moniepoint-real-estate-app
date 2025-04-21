import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constants.dart';
import './search.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0), // start off-screen to the left
      end: Offset.zero, // slide into place
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _radiusAnimation = Tween<double>(begin: 0, end: 30).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward(); // Start both animations
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SlideTransition(
          position: _slideAnimation,
          child: SearchForm(),
        ),
        AnimatedBuilder(
          animation: _radiusAnimation,
          builder: (context, child) {
            return CircleAvatar(
              radius: _radiusAnimation.value,
              backgroundImage: const AssetImage(PROFILE_PICTURE),
            );
          },
        ),
      ],
    );
  }
}
