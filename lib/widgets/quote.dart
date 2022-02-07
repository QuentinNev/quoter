import 'package:flutter/material.dart';
import 'package:quoter/models/quote.dart';

class QuoteDisplay extends StatefulWidget {
  const QuoteDisplay({Key? key}) : super(key: key);

  @override
  _QuoteDisplayState createState() => _QuoteDisplayState();
}

class _QuoteDisplayState extends State<QuoteDisplay> {
  String _quote = "";
  String _author = "";

  void changeQuote(Quote quote) {
    setState(() {
      _quote = quote.body;
      _author = quote.author;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text.rich(TextSpan(children: <TextSpan>[
          TextSpan(
              text: _quote,
              style: const TextStyle(fontSize: 20, fontStyle: FontStyle.italic))
        ])),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            _author,
            style: const TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }
}
