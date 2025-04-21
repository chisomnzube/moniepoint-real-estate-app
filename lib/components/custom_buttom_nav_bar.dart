import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/screens/home/home.dart';
import 'package:real_estate_app/screens/search/search.dart';
import 'package:real_estate_app/utils/constants.dart';
import 'package:real_estate_app/utils/enums.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedMenu,
    this.animate = true, // Default: true
  }) : super(key: key);

  final MenuState selectedMenu;
  final bool animate;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    if (widget.animate) {
      Future.delayed(const Duration(milliseconds: 4000), () {
        if (mounted) _controller.forward();
      });
    } else {
      _controller.value = 1; // Instantly jump to the end
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildNavItems(String image, MenuState menuState, VoidCallback link) {
    final bool isActive = menuState == widget.selectedMenu;
    return InkWell(
      onTap: link,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        child: CircleAvatar(
          backgroundColor: isActive ? kPrimaryColor : Colors.black,
          radius: 150,
          child: SvgPicture.asset(
            image,
            width: 40,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.transparent,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, -15),
              blurRadius: 200,
              color: const Color(0xFFDADADA).withOpacity(0.15),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.symmetric(vertical: 13),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              color: Color(0XFF2B2B2B),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildNavItems("assets/icons/search.svg", MenuState.search,
                    () => Get.toNamed(SearchScreen.routeName)),
                buildNavItems(
                    "assets/icons/message.svg", MenuState.message, () {}),
                buildNavItems("assets/icons/home.svg", MenuState.home,
                    () => Get.toNamed(HomeScreen.routeName)),
                buildNavItems(
                    "assets/icons/heart.svg", MenuState.favorite, () {}),
                buildNavItems(
                    "assets/icons/user.svg", MenuState.profile, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
