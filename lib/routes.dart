import './favorite_page.dart';
import './overall_theme.dart';
import './share_page.dart';
import 'package:flutter/material.dart';

import 'main.dart';
import 'newHomePage.dart';

class CustomRouter{
  static Route<dynamic> generateRoute (RouteSettings settings){
    switch (settings.name){
      case '/home':
        return MaterialPageRoute(builder:(_) => Home());
      case '/favorite':
        return MaterialPageRoute(builder: (_) => FavoritePage());
      case '/share':
        return MaterialPageRoute(builder: (_) => SharePage());
      case '/nhome':
        return MaterialPageRoute(builder: (_) => NewHomePage());
      default:
        return MaterialPageRoute(builder:(_) => ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.lightTheme.bottomAppBarColor,
        title: Text('ERROR'),
      ),
      body: Center(
        child: Image.asset('assets/error.png'),
      ),
    );
  }
}