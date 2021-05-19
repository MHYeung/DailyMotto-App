/*  Share page -> Save picture with the motto
1. Resizeable, editable Text
2. Draggable Text
3. Importable pictures from device
4. Select pictures from API maybe?
5. Save the file to local device
*/

import 'package:flutter/material.dart';
import 'package:motto/overall_theme.dart';
import 'package:share/share.dart';

class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration:
            BoxDecoration(color: CustomTheme.lightTheme.backgroundColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 2 / 3,
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    fillColor: Colors.blue,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: CustomTheme.lightTheme.buttonColor),
                onPressed: () {
                  setState(() {
                    if (_textController.text.isEmpty) {
                      print('Please enter something');
                  } else {
                    Share.share(_textController.text);
                  }
                  });
                },
                icon: Icon(Icons.share),
                label: Text('分享金句'))
          ],
        ),
      ),
    );
  }
}
