// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/word.dart';

class Words with ChangeNotifier {
  static List<Word> _allWord = [];

  List<Word> get allWord => _allWord;

  int get totalWord => _allWord.length;

  Word selectById(String id) =>
      _allWord.firstWhere((element) => element.id == id);

  Future<void> initialData() async {
    Uri url = Uri.parse(
        'https://kamus-632a9-default-rtdb.asia-southeast1.firebasedatabase.app/kamus.json');

    var resultGetData = await http.get(url);

    var dataResponse = json.decode(resultGetData.body) as Map<String, dynamic>;

    _allWord = [];

    dataResponse.forEach((key, value) {
      _allWord.add(
        Word(
          id: key,
          word: value['kata'],
          definition: value['definisi'],
        ),
      );
    });
    _allWord.sort((a, b) => a.word.compareTo(b.word));
    notifyListeners();
  }
}
