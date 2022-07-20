// ignore_for_file: avoid_print

import 'word.dart';

class AhoCorasick {
  List<Word> keywords = [];
  AhoCorasick(this.keywords) {
    _buildTables(keywords);
  }

  var gotoFn_ = {};
  var output_ = {};
  var failure_ = {};

  _buildTables(List<Word> keywords) {
    var gotoFn = {0: {}};
    var output = {};
    var state = 0;

    for (var i = 0; i < keywords.length; i++) {
      var curr = 0;
      var id = keywords[i].id;
      var word = keywords[i].word.toLowerCase();
      for (var j = 0; j < word.length; j++) {
        var l = word[j];
        if (gotoFn[curr]!.isNotEmpty & gotoFn[curr]!.containsKey(l)) {
          curr = gotoFn[curr]![l];
          output[curr].add(id);
        } else {
          state++;
          gotoFn[curr]![l] = state;
          gotoFn[state] = {};
          curr = state;
          output[state] = [id];
        }
      }
    }

    var failure = {};
    var xs = [];

    gotoFn[0]!.forEach((k, v) {
      var state = v;
      failure[state] = 0;
      xs.add(state);
    });

    while (xs.isNotEmpty) {
      var r = xs[0];
      xs.removeAt(0);

      gotoFn[r]!.forEach((k, v) {
        xs.add(v);
        var state = failure[r];
        while ((state > 0) & !(gotoFn[state]!.containsKey(k))) {
          state = failure[state];
        }
        if (gotoFn[state]!.containsKey(k)) {
          var fs = gotoFn[state]![k];
          failure[v] = fs;
          // output[v] = output[v] + output[fs];
        } else {
          failure[v] = 0;
        }
      });
    }
    gotoFn_ = gotoFn;
    output_ = output;
    failure_ = failure;
  }

  search(String string) {
    var state = 0;
    var result = [];
    for (var i = 0; i < string.length; i++) {
      var l = string[i];
      while ((state > 0) & !(gotoFn_[state].containsKey(l))) {
        // state = failure_[state];
        return [];
      }
      if (!(gotoFn_[state].containsKey(l))) {
        continue;
      }

      state = gotoFn_[state][l];
      if ((i + 1) == string.length) {
        if (output_[state].length > 0) {
          result = output_[state];
        }
      }
    }
    return result;
  }
}
