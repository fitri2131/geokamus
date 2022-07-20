// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geokamus/models/word.dart';
import 'package:geokamus/widgets/word_item.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/words.dart';

class FavoriteScreen extends StatefulWidget {
  static const name = 'Favorit';
  static const routeName = '/favorites';
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Words>(context).initialData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  List<Word> favoriteItem = [];
  int totalFavorite = 0;

  Future<void> getPreference(Words words) async {
    final prefs = await SharedPreferences.getInstance();
    if (words.totalWord > 0) {
      if (prefs.containsKey('favorites')) {
        final List<String>? favorites = prefs.getStringList('favorites');
        favoriteItem = [];
        favorites?.forEach((favorite) {
          var word = words.selectById(favorite);
          favoriteItem.add(
            Word(
              id: word.id,
              definition: word.definition,
              word: word.word,
            ),
          );
        });
        setState(() {
          totalFavorite = favoriteItem.length;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final words = Provider.of<Words>(context);
    return FutureBuilder(
      future: getPreference(words),
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
                    'Kata Favorit',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 25.0),
                    child: const Icon(Icons.favorite_border_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              (totalFavorite == 0)
                  ? const Expanded(
                      child: Center(
                        child: Text('Tidak ada kata favorit'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: totalFavorite,
                        itemBuilder: (context, position) {
                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: WordItem(
                              favoriteItem[position].id,
                              favoriteItem[position].definition,
                              favoriteItem[position].word,
                            ),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
