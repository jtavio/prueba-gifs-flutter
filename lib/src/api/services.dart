import 'dart:convert';

import 'package:pruebagifs/src/constants.dart';
import 'package:http/http.dart';
import 'package:pruebagifs/src/models/gifs_model.dart';

class HttpService {
  final url = Uri.parse(
      'https://api.giphy.com/v1/gifs/trending?api_key=${Constants.apikey}&limit=25&rating=g');
  // search?q=${encodeURI(category)}&limit=10&api_key=${Constants.apikey}

  Future<DataModel?> getInitCategory() async {
    try {
      //await get(Uri.parse('$url/author,title/$name;$title'));
      final res = await get(url);
      final result = jsonDecode(res.body);
      final data = DataModel.fromJson(result);
      print(data);
      return data;
    } catch (e) {
      print('e $e');
    }
    return null;
  }

  Future searchGifs(String query) async {
    try {
      final res = await get(Uri.parse(
          'https://api.giphy.com/v1/gifs/search?api_key=${Constants.apikey}&q=$query&limit=25&offset=0&rating=g&lang=es'));
      final result = jsonDecode(res.body);
      final data = DataModel.fromJson(result);
      print(data);
      return data;
    } catch (e) {
      print('e $e');
    }
    return null;
  }
}
