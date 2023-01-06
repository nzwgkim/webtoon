import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];

    // final url = Uri.https('$baseUrl', '$today');
    // alternative way???
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // String get body
      // package:http/src/response.dart
      // print(response.body);

      //dynamic jsonDecode(String source, {Object? Function(Object?, Object?)? reviver})
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        // final oneWebToon = WebtoonModel.fromJson(webtoon);
        // print(oneWebToon.title);
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      // print(webtoonInstances.length);
      return webtoonInstances;
    }
    throw Error();
  }
}
