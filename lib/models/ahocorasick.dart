// ignore_for_file: avoid_print

import 'word.dart';

class AhoCorasick {
  // List<Word> keywords = [];
  String keywords = "";
  AhoCorasick(this.keywords) {
    _buildTables(keywords);
  }

  var gotoFn_ = {};
  var output_ = {};
  var failure_ = {};
  var stringlength = 0;

  _buildTables(String string) {
    var gotoFn = {0: {}};
    var output = {};
    var state = 0;

    var curr = 0;
    for (var j = 0; j < string.length; j++) {
      var l = string[j];
      if (gotoFn[curr]!.isNotEmpty & gotoFn[curr]!.containsKey(l)) {
        curr = gotoFn[curr]![l];
        // output[curr].add(string);
      } else {
        state++;
        gotoFn[curr]![l] = state;
        gotoFn[state] = {};
        curr = state;
        output[state] = [];
      }
    }

    output[curr].add(string);

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
    stringlength = string.length;
  }

  search(List<Word> keywords) {
    var state = 0;
    // var result = [];
    List<Word> result = [];
    for (var i = 0; i < keywords.length; i++) {
      var word = keywords[i].word.toLowerCase();
      for (var j = 0; j < word.length; j++) {
        var l = word[j];
        while ((state > 0) & !(gotoFn_[state].containsKey(l))) {
          state = failure_[state];
          // return;
        }
        if (!(gotoFn_[state].containsKey(l))) {
          continue;
        }

        state = gotoFn_[state][l];
        if (output_[state].length > 0 && (j+1) >= stringlength) {
          result.add( keywords[i] );
          break;
        }
      }
    }
    return result;
  }
}
