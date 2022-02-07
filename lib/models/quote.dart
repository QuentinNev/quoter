class Quote {
  final String body;
  final String author;

  Quote(this.body, this.author);

  Quote.fromJson(Map<String, dynamic> json)
      : body = json['name'],
        author = json['email'];

  Map<String, dynamic> toJson() => {
        'name': body,
        'email': author,
      };
}