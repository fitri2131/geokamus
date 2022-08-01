// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/about.dart';

class Abouts with ChangeNotifier {
  static List<About> _allAbout = [];

  List<About> get allAbout => _allAbout;

  int get totalAbout => _allAbout.length;

  Future<void> initialData() async {
    Uri url = Uri.parse(
        'https://kamus-69b35-default-rtdb.asia-southeast1.firebasedatabase.app/about.json');

    var resultGetData = await http.get(url);

    var dataResponse = json.decode(resultGetData.body) as Map<String, dynamic>;

    _allAbout = [];

    dataResponse.forEach((key, value) {
      _allAbout.add(
        About(
          application: value['application'],
          college: value['college'],
          description: value['description'],
          developer: value['developer'],
          email: value['email'],
          stamp: value['stamp'],
        ),
      );
    });
    notifyListeners();
  }
}
