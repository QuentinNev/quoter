import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:quoter/models/quote.dart';

Future<Quote> getNewQuote() async {
  var _quote;
  var _author;
  var _url = Uri.https('api.quotable.io', '/random', {'q': 'http'});

  var response = await http.get(_url);
  if (response.statusCode == 200) {
    var decoded = convert.jsonDecode(response.body) as Map<String, dynamic>;
    _quote = decoded['content'];
    _author = decoded['author'];
    return Quote(_quote, _author);
  } else {
    return Quote(':\'c', 'ERROR');
  }
}
