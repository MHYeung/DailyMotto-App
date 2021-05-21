import 'package:flutter/material.dart';

import 'Model/bannerAd.dart';
import 'overall_theme.dart';

class BasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.gif'), fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: CustomTheme.lightTheme.buttonColor.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  padding: EdgeInsets.all(5.0),
                  elevation: 2.0,
                ),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
                icon: Icon(Icons.book_sharp, size: 40, color: Colors.white,),
                label: Text(
                  '查看金句',
                  style: TextStyle(fontSize: 40,color: Colors.white, fontWeight: FontWeight.bold),
                )),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: CustomTheme.lightTheme.buttonColor.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0))),
                  padding: EdgeInsets.all(5.0),
                  elevation: 2.0,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/favorite');
                },
                icon: Icon(Icons.bookmark_outline, size: 40,color: Colors.white,),
                label: Text(
                  '已儲存的金句',
                  style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                )),
            HomePageAd()
          ],
        ),
      )),
    );
  }
}
