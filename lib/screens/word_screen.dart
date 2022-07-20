// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/words.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordScreen extends StatefulWidget {
  static const routeName = '/word';
  const WordScreen({super.key});

  @override
  State<WordScreen> createState() => _WordScreenState();
}

class _WordScreenState extends State<WordScreen> {
  bool isInit = true;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    setPreference('a');
  }

  bool isFavorite = false;

  Future<void> setPreference(String favorite) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? favorites = prefs.getStringList('favorites');
    if (isFavorite) {
      favorites?.add(favorite);
    } else {
      favorites?.remove(favorite);
    }
    print(favorites);
    var f = favorites;
    f ??= [];
    print(f);
    await prefs.setStringList('favorites', f);
  }

  Future<void> getPreference(String id) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('favorites')) {
      final List<String>? favorites = prefs.getStringList('favorites');
      if (isInit) {
        if (favorites != null) {
          if (favorites.contains(id)) {
            setState(() {
              isFavorite = true;
            });
          }
        }
      }
      isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context, listen: false);
    final wordId = ModalRoute.of(context)?.settings.arguments as String;
    final selectWord = words.selectById(wordId);

    return FutureBuilder(
      future: getPreference(wordId),
      builder: (context, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(left: 25.0),
                      width: 35,
                      height: 35,
                      child: const Icon(Icons.chevron_left),
                    ),
                  ),
                  Text(
                    'Detail Kata',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: const Icon(Icons.text_fields_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 55),
              Row(
                children: [
                  const SizedBox(width: 25),
                  Text(
                    selectWord.word,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(flex: 1, child: Container(width: 100)),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite;
                        setPreference(wordId);
                      });
                    },
                    child: Icon(
                      (isFavorite)
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: (isFavorite) ? Colors.red : Colors.black,
                    ),
                  ),
                  const SizedBox(width: 25),
                ],
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 18.0),
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
                margin: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(selectWord.definition),
              )
            ],
          ),
        ),
      ),
    );
  }
}
