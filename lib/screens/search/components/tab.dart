import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:real_estate_app/controllers/home.controller.dart';
import 'package:real_estate_app/utils/constants.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab>
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

  HomeController homeController = Get.find();
  IconData _selectedIcon = FontAwesomeIcons.wallet;
  final Color highlightColor = kPrimaryColor;

  void _onNavItemSelected(IconData icon) {
    setState(() {
      _selectedIcon = icon;
    });
    Navigator.pop(context); // Dismiss the popup
  }

  Widget buildNavItem(IconData icon, String name) {
    final bool isSelected = _selectedIcon == icon;
    final Color itemColor = isSelected ? highlightColor : Colors.black;

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        foregroundColor: itemColor,
        alignment: Alignment.centerLeft,
      ),
      onPressed: () {
        if (icon == FontAwesomeIcons.wallet) {
          homeController.isSimpleMarker.value = false;
        } else {
          homeController.isSimpleMarker.value = true;
        }
        _onNavItemSelected(icon);
      },
      child: Row(
        children: [
          Icon(icon, color: itemColor),
          const SizedBox(width: 10),
          Text(name, style: TextStyle(color: itemColor)),
        ],
      ),
    );
  }

  void _showLayerMenu(BuildContext context, Offset position) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    // Shift position upward and leftward
    final Offset adjustedPosition = Offset(position.dx - 60, position.dy - 180);

    showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromPoints(adjustedPosition, adjustedPosition),
        Offset.zero & overlay.size,
      ),
      elevation: 8,
      color: const Color(0xFFFDF8F0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: buildNavItem(CupertinoIcons.checkmark_shield, "Cosy areas"),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: buildNavItem(FontAwesomeIcons.wallet, "Price"),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child:
              buildNavItem(FontAwesomeIcons.basketShopping, "Infrastructure"),
        ),
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: buildNavItem(CupertinoIcons.layers_alt, "Without any layer"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Column(
        children: [
          GestureDetector(
            onTapDown: (details) =>
                _showLayerMenu(context, details.globalPosition),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0XFF747474),
              ),
              child: Icon(_selectedIcon, size: 30, color: Colors.white),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0XFF747474),
            ),
            child: const Icon(CupertinoIcons.location,
                size: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
