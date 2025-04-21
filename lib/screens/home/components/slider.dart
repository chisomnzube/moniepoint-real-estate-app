import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/utils/constants.dart';

class AutoSlideToComplete extends StatefulWidget {
  final String text;

  const AutoSlideToComplete({Key? key, required this.text}) : super(key: key);

  @override
  _AutoSlideToCompleteState createState() => _AutoSlideToCompleteState();
}

class _AutoSlideToCompleteState extends State<AutoSlideToComplete>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final double _sliderSize = 60;
  double _maxWidth = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use the actual parent width
        _maxWidth = constraints.maxWidth;

        // Update animation based on width
        _animation = Tween<double>(begin: 0, end: _maxWidth - _sliderSize)
            .animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

        // Trigger animation only once when layout is available
        if (!_controller.isAnimating && _controller.value == 0.0) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            _controller.forward();
          });
        }

        return Container(
          height: _sliderSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Stack(
                children: [
                  // White trail background that grows with the animation
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: _animation.value + _sliderSize,
                      decoration: BoxDecoration(
                        color: Color(0xFFD0BDA4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),

                  // Text revealed over the white trail
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: (_animation.value + _sliderSize) / _maxWidth,
                      child: Container(
                        width: _maxWidth,
                        alignment: Alignment.center,
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            color: BlackColor,
                            // fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // The moving circle
                  Positioned(
                    left: _animation.value,
                    top: 0,
                    child: Container(
                      width: _sliderSize,
                      height: _sliderSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        CupertinoIcons.chevron_forward,
                        color: BlackColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
