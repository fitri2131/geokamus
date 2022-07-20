import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconWithTextItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const IconWithTextItem(this.color, this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 15),
        Text(text, style: GoogleFonts.getFont('Poppins', color: color)),
      ],
    );
  }
}
