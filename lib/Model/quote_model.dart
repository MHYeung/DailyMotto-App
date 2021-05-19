// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.code,
    this.data,
  });

  int code;
  Data data;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    code: json["code"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.tag,
    this.origin,
    this.content,
    this.datetime,
  });

  String id;
  String tag;
  String origin;
  String content;
  String datetime;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    tag: json["tag"],
    origin: json["origin"],
    content: json["content"],
    datetime: json["datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "origin": origin,
    "content": content,
    "datetime": datetime,
  };
}
