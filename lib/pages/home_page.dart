import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import 'package:quoter/managers/quote_manager.dart';
import 'package:quoter/managers/favorite_quote_manager.dart';
import 'package:quoter/models/quote.dart';

import 'package:quoter/pages/favorite_page.dart';
import 'package:quoter/widgets/quote_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quote"),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FavoritePage())),
          ),
        ],
      ),
      body: _ScrollableQuoteView(),
      floatingActionButton: FloatingActionButton(
        onPressed: QuoteManager.instance.next,
        tooltip: 'New quote',
        child: const Icon(Icons.subdirectory_arrow_left),
      ),
    );
  }
}

class _ScrollableQuoteView extends StatelessWidget with GetItMixin {
  _ScrollableQuoteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Connects the the QuoteManager event stream
    AsyncSnapshot<Quote> snapshot =
        watchStream((QuoteManager m) => m.stream, Quote.none());

    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 100,
        ),
        child: Center(
          child: _buildSnapshot(context, snapshot),
        ),
      ),
    );
  }

  Widget _buildSnapshot(BuildContext context, AsyncSnapshot<Quote> snapshot) {
    if (snapshot.hasData) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          QuoteView(snapshot.data!),
          Padding(
              padding: const EdgeInsets.only(top: 16),
              child: IconButton(
                icon: Icon(Icons.favorite),
                color: _getColor(snapshot.data!.isFavorite),
                onPressed: () =>
                    FavoriteQuoteManager.instance.add(snapshot.data!),
              )),
        ],
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}',
          style: TextStyle(color: Colors.red, fontSize: 32));
    }
    return const CircularProgressIndicator();
  }

  Color _getColor(favorite) {
    print("DEBUG : " + favorite.toString());
    return (favorite) ? Colors.red : Colors.blue;
  }
}
