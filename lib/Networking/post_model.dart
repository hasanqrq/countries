// To parse this JSON data, do
//
//     final post = postFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Post postFromMap(String str) => Post.fromMap(json.decode(str));

String postToMap(Post data) => json.encode(data.toMap());

class Post {
    Post({
        required this.error,
        required this.msg,
        required this.data,
    });

    bool error;
    String msg;
    List<Datum> data;
    

    factory Post.fromMap(Map<String, dynamic> json) => Post(
        error: json["error"],
        msg: json["msg"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "error": error,
        "msg": msg,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
    };
}

class Datum {
    Datum({
        required this.name,
        required this.currency,
        required this.unicodeFlag,
        required this.flag,
        required this.dialCode,
    });

    String name;
    String currency;
    String unicodeFlag;
    String flag;
    String dialCode;

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        name: json["name"],
        // currency: json["currency"] == null ? null : json["currency"], 
        currency: json["currency"],
        unicodeFlag: json["unicodeFlag"],
        // flag: json["flag"] == null ? null : json["flag"],  
        flag: json["flag"],
        // dialCode: json["dialCode"] == null ? null : json["dialCode"],
        dialCode: json["dialCode"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        // "currency": currency == null ? null : currency,
        "currency": currency,
        "unicodeFlag": unicodeFlag,
        // "flag": flag == null ? null : flag,
        "flag": flag,
        // "dialCode": dialCode == null ? null : dialCode,
        "dialCode": dialCode ,
    };
}

Future<List<Post>> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://countriesnow.space/api/v0.1/countries/info?returns=currency,flag,unicodeFlag,dialCode'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}
