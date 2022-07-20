class Word {
  String id, word, definition;

  Word({
    required this.id,
    required this.definition,
    required this.word,
  });

  @override
  String toString() {
    return "$id:$word";
  }
}
