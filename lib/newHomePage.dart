import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:motto/overall_theme.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'Model/AdManager.dart';
import 'Model/quote_provider.dart';


String quote ='';
class NewHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height-60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: CustomTheme.lightTheme.accentColor),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    onPressed: () => Share.share(quote),
                    child: Text('分享'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('儲存'),
                  ),
                  ElevatedButton(
                    onPressed: () => context.read<Counter>().increment(),
                    child: Text('下一句'),
                  ),
                ],
              ),
              //HomePageAd(),
            ],
          ),
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
            quote = snapshot.data[context.watch<Counter>().count];
            return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                height: MediaQuery.of(context).size.height*0.7,
                child: Center(
                    child: Text(
                  snapshot.data[context.watch<Counter>().count],
                  maxLines: 8,
                  style: TextStyle(fontSize: 30),
                )));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        });
  }
}

class HomePageAd extends StatefulWidget {
  @override
  _HomePageAdState createState() => _HomePageAdState();
}

class _HomePageAdState extends State<HomePageAd> {
  BannerAd _ad;
  bool _isAdLoaded = false;

  @override
  void dispose() {
    // COMPLETE: Dispose a BannerAd object
    _ad.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ad = BannerAd(
        adUnitId: AdManager.bannerAdUnitID,
        size: AdSize.banner,
        request: AdRequest(),
        listener: AdListener(onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(
              'Ad load failed (code=${error.code} message = ${error.message}');
        }));

    _ad.load();
  }

  @override
  Widget build(BuildContext context) {
    return _isAdLoaded
        ? Container(
            child: AdWidget(
              ad: _ad,
            ),
            width: _ad.size.width.toDouble(),
            height: 72.0,
            alignment: Alignment.center)
        : Container(
            height: 72.0,
          );
  }
}
