import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//all API call will handel here
class TodoServices {
  static Future<bool> deleteById(String id) async {
    var url = "https://api.nstack.in/v1/todos/$id";
    var uri = Uri.parse(url);
    var responce = await http.delete(uri);
    return responce.statusCode == 200;
  }

  static Future<List?> fetchTodo() async {
    var uri = Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=10");
    var res = await http.get(uri);
    if (res.statusCode == 200) {
      final respoce = jsonDecode(res.body) as Map;
      final re = respoce["items"] as List;
      return re;
    } else {
      return null;
    }
  }

  static Future<bool>updateTodo(String id , Map data)async{
    final url = "https://api.nstack.in/v1/todos/$id";
    final urr = Uri.parse(url);
    final responce = await http.put(
        urr,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'}
    );
    return responce.statusCode == 200;
  }

  static Future<bool> setTodo(Map body) async {
    final url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    var responce = await http.post
      (
        uri,
        body:
        jsonEncode(body),
        headers: {'Content-Type': 'application/json'}
    );
    return (responce.statusCode == 201);
}
}
