import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String menu;
  final String route;

  const MenuItem(this.color, this.icon, this.menu, this.route, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
