import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'about_screen.dart';
import 'favorite_screen.dart';
import 'words_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            Expanded(child: Container(height: 100)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Image.asset('assets/images/geo.png'),
            ),
            Text(
              'GEOKAMUS',
              style: GoogleFonts.getFont(
                'Acme',
                color: const Color.fromRGBO(63, 89, 125, 1.0),
                fontWeight: FontWeight.w900,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Kamus Istilah Geografi',
              style: TextStyle(
                color: Color.fromRGBO(93, 116, 138, 1.0),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () => Navigator.pushNamed(context, WordsScreen.routeName),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: 130.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cari Kata',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 18.0,
                    ),
                    const SizedBox(width: 15.0),
                  ],
                ),
              ),
            ),
            Expanded(child: Container(height: 100)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, FavoriteScreen.routeName),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(220, 73, 85, 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        FavoriteScreen.name,
                        style: GoogleFonts.getFont('Poppins'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    AboutScreen.routeName,
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(8, 129, 163, 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        AboutScreen.name,
                        style: GoogleFonts.getFont('Poppins'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              'Created by Fitri Hamsa',
              style: TextStyle(
                color: Color.fromRGBO(63, 89, 125, 1.0),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
