import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lpinyin/lpinyin.dart';
import 'dart:async';

void main() async {
  int times = 0;
  final myFile = File(
      'C:/Users/johny/projects/flutterprojects/motto/lib/Model/content.txt');
  final sink = myFile.openWrite(mode: FileMode.append);
  const _timer = const Duration(seconds: 80);
  FormData formData;
  Options options = Options(responseType: ResponseType.plain);
  var dio = Dio();
  Timer.periodic(_timer, (timer) async {
    final response = await dio.post('https://api.xygeng.cn/one',
        data: formData, options: options);
    final res = jsonDecode(response.data);
    final content =
        ChineseHelper.convertToTraditionalChinese(res['data']['content']);
    print(content);
    sink.write(content + '\"');
    if(times > 500){
      sink.close();
    }
  });
}
