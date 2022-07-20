// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geokamus/models/ahocorasick.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../models/word.dart';
import '../providers/words.dart';
import '../widgets/word_item.dart';

class WordsScreen extends StatefulWidget {
  static const routeName = '/words';
  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  bool isInit = true;
  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<Words>(context).initialData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  List<Word> words = [];
  dynamic allWord;
  Future<void> getWords(Words wordsProvider) async {
    if (wordsProvider.totalWord > 0 && allWord == null) {
      setState(() {
        words = wordsProvider.allWord;
        allWord = wordsProvider;
      });
    }
  }

  searh(string, keywords) {
    if (string.length > 0) {
      Stopwatch stopwatch = Stopwatch()..start();
      var ac = AhoCorasick(keywords);
      var result = ac.search(string);
      List<Word> foundStr = [];
      for (var i = 0; i < result.length; i++) {
        var word = allWord.selectById(result[i]);
        foundStr.add(Word(
          id: word.id,
          definition: word.definition,
          word: word.word,
        ));
      }
      setState(() {
        words = foundStr;
      });
      var timeExecution = stopwatch.elapsedMilliseconds;
      Fluttertoast.showToast(
        msg: "Waktu Pencarian Aho-Corasick: $timeExecution ms",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: const Color.fromRGBO(8, 129, 163, 1.0),
        textColor: Colors.white,
        fontSize: 14,
      );
    } else {
      setState(() {
        words = allWord.allWord;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final allWordsProvider = Provider.of<Words>(context);

    return FutureBuilder(
      future: getWords(allWordsProvider),
      builder: (context, _) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: (allWordsProvider.totalWord == 0)
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromRGBO(8, 129, 163, 1.0),
                    ),
                  )
                : Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const SizedBox(
                              width: 35.0,
                              height: 35.0,
                              child: Icon(Icons.chevron_left_rounded),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              onChanged: (text) {
                                searh(text, allWordsProvider.allWord);
                              },
                              decoration: const InputDecoration(
                                focusColor: Color.fromRGBO(63, 89, 125, 1.0),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 20.0),
                                suffixIcon: Icon(
                                  Icons.search,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: (words.isEmpty)
                            ? const Center(
                                child: Text('Tidak ada kata'),
                              )
                            : ListView.builder(
                                itemCount: words.length,
                                itemBuilder: (context, position) {
                                  return WordItem(
                                    words[position].id,
                                    words[position].definition,
                                    words[position].word,
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
