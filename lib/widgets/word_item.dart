import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../screens/word_screen.dart';

class WordItem extends StatelessWidget {
  final String id, definition, word;
  // final bool isFavorite;

  const WordItem(this.id, this.definition, this.word, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(63, 89, 124, 0.2),
            spreadRadius: 0,
            blurRadius: 3,
            offset: Offset(0, 7),
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 2,
            height: 30,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 189, 182, 182),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                WordScreen.routeName,
                arguments: id,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    word,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    definition,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.getFont('Poppins', fontSize: 10.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 7),
          // isFavorite
          //     ? const Icon(
          //         Icons.favorite,
          //         color: Color.fromRGBO(220, 73, 85, 1.0),
          //       )
          //     : const Icon(Icons.favorite_border_outlined),
        ],
      ),
    );
  }
}
