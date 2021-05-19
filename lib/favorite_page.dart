import './Model/preference_service.dart';
import './Model/saved_items.dart';
import './overall_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Scaffold(
          backgroundColor: CustomTheme.lightTheme.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/home');
                }),
            backgroundColor: CustomTheme.lightTheme.bottomAppBarColor,
            title: Text('已儲存的金句',
                style: TextStyle(
                    color: Colors.yellow[300],
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5)),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height - 80,
            width: double.infinity,
            child: SavedQuotes(),
          )),
    );
  }
}

class SavedQuotes extends StatefulWidget {
  @override
  _SavedQuotesState createState() => _SavedQuotesState();
}

class _SavedQuotesState extends State<SavedQuotes> {
  PreferencesService _preference = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SavedItems>(
        future: _preference.getQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data.savedquotes.length == 0)
                ? Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('還未有儲存金句', style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
                    SizedBox(height: 30),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(primary: CustomTheme.lightTheme.buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                      onPressed: (){
                      Navigator.popAndPushNamed(context, '/home');
                    }, label: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('去找新金句', style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),),
                    ), icon: Icon(Icons.arrow_back_sharp),),
                  ],
                ))
                : ListView.builder(
                    reverse: false,
                    itemCount: snapshot.data.savedquotes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data == null
                          ? Text('Nothing saved')
                          : Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ListTile(
                                tileColor: Colors.green[100],
                                contentPadding: EdgeInsets.all(4.0),
                                leading: CircleAvatar(
                                  child: Text('${index + 1}'),
                                  radius: 30,
                                ),
                                title: Text(snapshot.data.savedquotes[index]),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                            false, // user must tap button!
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            titlePadding: EdgeInsets.symmetric(
                                                horizontal: 15.0,
                                                vertical: 24.0),
                                            title: Text(
                                              '確定要移除金句?',
                                              style: TextStyle(fontSize: 40),
                                            ),
                                            actionsPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 20),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(
                                                  '確定',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.red),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    snapshot.data.savedquotes
                                                        .removeAt(index);
                                                    snapshot.data.quotesid
                                                        .removeAt(index);
                                                    _preference.saveQuotes(
                                                        snapshot.data);
                                                  });
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  '取消',
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.blue),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }),
                              ),
                            );
                    });
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        });
  }
}
