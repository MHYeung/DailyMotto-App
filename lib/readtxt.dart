import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  var config = File('C:/Users/johny/projects/flutterprojects/motto/lib/Model/content.txt');

  // Put the whole file in a single string.
  var stringContents = await config.readAsString();
  List<String> pat = stringContents.split('"');
  print(pat);
  print(pat.length);

}