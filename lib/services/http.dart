import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void _getNewQuote() async {
  var url = Uri.https('api.quotable.io', '/random', {'q': 'http'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    setState(() {
      var decoded = convert.jsonDecode(response.body) as Map<String, dynamic>;
      _quote = decoded['content'];
      _author = decoded['author'];
    });
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}
