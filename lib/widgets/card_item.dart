import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Color backgroundColor;
  final Widget child;
  final Color shadowColor;
  const CardItem(this.backgroundColor, this.child, this.shadowColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 21),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }
}
