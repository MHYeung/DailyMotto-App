import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:motto/Model/AdManager.dart';
import 'package:share/share.dart';

import './Model/preference_service.dart';

import './Model/notification_service.dart';
import './overall_theme.dart';
import 'package:flutter/material.dart';

import 'Model/bannerAd.dart';
import 'Model/quote_provider.dart';
import 'package:provider/provider.dart';

String quote = '';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.lightTheme.bottomAppBarColor,
        title: Text('人生格言'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/base');
                }),
        actions: [
          IconButton(icon: Icon(Icons.favorite), onPressed: (){
            Navigator.pushNamed(context, '/favorite');
          })
        ],
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PreferencesService _preference = PreferencesService();
  List<String> _quoteList;
  InterstitialAd _interstitialAd;
  int _pressCount = 0;

  Future<List<String>> _getQuotes() async {
    _preference.getQuotes().then((value) => _quoteList = value);
    String raw = await rootBundle.loadString('assets/content.txt');
    List<String> quotes = raw.split('"');
    NotificationService().scheduledNotification();
    return quotes;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _interstitialAd.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _interstitialAd = InterstitialAd(
        adUnitId: AdManager.interstitialAdUnitID,
        listener: AdListener(),
        request: AdRequest());
    _interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - 80,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.white60, Colors.yellow, Colors.pink[200]])),
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: FutureBuilder(
              future: _getQuotes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  quote = snapshot.data[context.watch<Counter>().count];
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      height: MediaQuery.of(context).size.height * 0.7,
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
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                func: () {
                  context.read<Counter>().decrement();
                  _pressCount++;
                  if (_pressCount % 7 == 0) {
                    _interstitialAd.show();
                    _interstitialAd.dispose();
                    _interstitialAd.load();
                  }
                },
                title: '上一句'),
            CustomButton(func: () => Share.share(quote), title: '分享'),
            CustomButton(
                func: () {
                  if (_quoteList.contains(quote) == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('你已儲存過這句金句。'),
                      elevation: 10,
                      action: SnackBarAction(
                        label: '查看已儲存的金句',
                        onPressed: () {
                          Navigator.pushNamed(context, '/favorite');
                        },
                      ),
                    ));
                  } else {
                    _quoteList.add(quote);
                  }
                  _preference.saveQuotes(_quoteList);
                  print(_quoteList);
                },
                title: '儲存句子'),
            CustomButton(
                func: () {
                  context.read<Counter>().increment();
                  _pressCount++;
                  if (_pressCount % 7 == 0) {
                    _interstitialAd.show();
                    _interstitialAd.dispose();
                    _interstitialAd.load();
                  }
                },
                title: '下一句'),
          ],
        ),
        HomePageAd()
      ]),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    @required this.func,
    @required this.title,
  }) : super(key: key);

  final Function func;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: CustomTheme.lightTheme.buttonColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        padding: EdgeInsets.all(5.0),
        elevation: 2.0,
      ),
      onPressed: func,
      child: Text(
        title,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

