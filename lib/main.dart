import './home_page.dart';
import './Model/notification_service.dart';
import 'package:flutter/material.dart';

import './overall_theme.dart';
import './routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(Base());
}

class Base extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: '/favorite',
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.lightTheme.bottomAppBarColor,
        title: Text('人生格言'),
        centerTitle: true,
        automaticallyImplyLeading: false,
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

