import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';

import 'Model/quote_provider.dart';

class NewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        width: double.infinity,
        child: Column(
          children: [
            Quote(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => context.read<Counter>().decrement(),
                  child: Text('上一句'),
                ),
                ElevatedButton(
                  onPressed: () => context.read<Counter>().increment(),
                  child: Text('下一句'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Quote extends StatelessWidget {
  const Quote({
    Key key,
  }) : super(key: key);

  Future<List<String>> _getQuotes() async {
    String raw = await rootBundle.loadString('assets/content.txt');
    List<String> quotes = raw.split('"');
    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Center(child:
                        Text(context.watch<Counter>().count.toString() + snapshot.data[context.watch<Counter>().count] )));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}
