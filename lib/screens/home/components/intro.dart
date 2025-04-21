import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constants.dart';

class HomeIntro extends StatefulWidget {
  const HomeIntro({super.key});

  @override
  State<HomeIntro> createState() => _HomeIntroState();
}

class _HomeIntroState extends State<HomeIntro>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _translateY;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _translateY = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(const Duration(milliseconds: 1000), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi, $USERNAME",
          style: TextStyle(
            color: SemiBlack,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 10),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _translateY.value),
                child: child,
              ),
            );
          },
          child: Text(
            "let's select your perfect place",
            style: TextStyle(
              color: BlackColor,
              fontSize: 40,
            ),
          ),
        ),
      ],
    );
  }
}
