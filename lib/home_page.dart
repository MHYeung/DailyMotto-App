import 'dart:convert';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:motto/Model/AdManager.dart';

import './Model/preference_service.dart';
import './Model/quote_model.dart';
import './Model/saved_items.dart';
import './Model/notification_service.dart';
import './overall_theme.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:lpinyin/lpinyin.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  Future<Welcome> futureWelcome;
  SavedItems _items;
  PreferencesService _preference = PreferencesService();
  Welcome _welcome;
  bool _isAdLoaded = false;
  BannerAd _ad;

  //admob

  @override
  void dispose() {
    // COMPLETE: Dispose a BannerAd object
    _ad.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureWelcome = _getData();
    _preference.getQuotes().then((value) => _items = value);
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

  Future<Welcome> _getData() async {
    final response = await http.get(Uri.parse('https://api.xygeng.cn/one'));

    if (response.statusCode == 200) {
      var result = Utf8Decoder().convert(response.bodyBytes);
      final welcome = welcomeFromJson(result);
      print(welcome.data.id);
      NotificationService().scheduledNotification(
          ChineseHelper.convertToTraditionalChinese(welcome.data.content));
      _welcome = welcome;
      return welcome;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('未能載入句子');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height-80,
      decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.white60, Colors.yellow, Colors.pink[200]])),
      padding: const EdgeInsets.only(bottom: 10.0, top:5.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: FutureBuilder<Welcome>(
              future: futureWelcome,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    child: Text(
                      ChineseHelper.convertToTraditionalChinese(
                          snapshot.data.data.content),
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  );
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
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    futureWelcome = _getData();
                    print('Button Pressed');
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: CustomTheme.lightTheme.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  padding: EdgeInsets.all(5.0),
                  elevation: 2.0,
                ),
                child: Text(
                  '下一句',
                  style: TextStyle(fontSize: 30),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: CustomTheme.lightTheme.buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                padding: EdgeInsets.all(5.0),
                elevation: 2.0,
              ),
              child: Text(
                '儲存句子',
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                if (_items.quotesid.contains(_welcome.data.id) == true) {
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
                  _items.savedquotes.add(
                      ChineseHelper.convertToTraditionalChinese(
                          _welcome.data.content));
                  _items.quotesid.add(_welcome.data.id);
                }
                _preference.saveQuotes(_items);
                print(_items.savedquotes);
              },
            ),
          ],
        ),
        _isAdLoaded ? Container(child: AdWidget(ad: _ad,), width: _ad.size.width.toDouble(), height: 72.0, alignment: Alignment.center) : Container(height: 72.0,),
      ]),
    );
  }
}
