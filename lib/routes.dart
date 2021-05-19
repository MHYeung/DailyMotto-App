import './favorite_page.dart';
import './overall_theme.dart';
import './share_page.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class CustomRouter{
  static Route<dynamic> generateRoute (RouteSettings settings){
    switch (settings.name){
      case '/home':
        return MaterialPageRoute(builder:(_) => Home());
      case '/favorite':
        return MaterialPageRoute(builder: (_) => FavoritePage());
      case '/share':
        return MaterialPageRoute(builder: (_) => SharePage());
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