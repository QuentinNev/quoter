class Quote {
  String body;
  String author;
  bool isFavorite;

  Quote(this.body, this.author, this.isFavorite);

  factory Quote.none() {
    return Quote("", "", false);
  }
}
