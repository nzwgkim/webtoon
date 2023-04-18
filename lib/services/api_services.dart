import 'package:dio/dio.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

import '../common/interceptor.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];

    // // final url = Uri.https('$baseUrl', '$today');
    // // alternative way???
    // final url = Uri.parse('$baseUrl/$today');
    // final response = await http.get(url);

    // if (response.statusCode == 200) {
    //   // String get body
    //   // package:http/src/response.dart
    //   // print(response.body);

    //   //dynamic jsonDecode(String source, {Object? Function(Object?, Object?)? reviver})
    //   final List<dynamic> webtoons = jsonDecode(response.body);
    //   for (var webtoon in webtoons) {
    //     // final oneWebToon = WebtoonModel.fromJson(webtoon);
    //     // print(oneWebToon.title);
    //     webtoonInstances.add(WebtoonModel.fromJson(webtoon));
    //   }
    //   // print(webtoonInstances.length);
    //   return webtoonInstances;
    // }

    final dio = Dio();

    dio.interceptors.add(CustomInterceptor());
    final response = await dio.get('$baseUrl/$today');
    // print(response.data);
    // print(response.statusCode);
    // print(response.data.length);

    if (response.statusCode == 200) {
      final List<dynamic> json = response.data;
      for (final Map<String, dynamic> ajson in json) {
        // print(ajson);
        webtoonInstances.add(WebtoonModel.fromJson(ajson));
        // print('add');
      }
      // print(webtoonInstances);
      return webtoonInstances;
    }

    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final dio = Dio();
    dio.interceptors.add(CustomInterceptor());
    final response = await dio.get("$baseUrl/$id");
    // print(response.data);

    if (response.statusCode == 200) {
      final json = response.data;
      return WebtoonDetailModel.fromJson(json);
    }
    // final url = Uri.parse("$baseUrl/$id");
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   final webtoon = jsonDecode(response.body);
    //   return WebtoonDetailModel.fromJson(webtoon);
    // }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];

    final dio = Dio();
    dio.interceptors.add(CustomInterceptor());

    final response = await dio.get("$baseUrl/$id/episodes");
    // print(response.data);

    if (response.statusCode == 200) {
      final json = response.data;
      for (final asjon in json) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(asjon));
      }
      return episodesInstances;
    }
    // final url = Uri.parse("$baseUrl/$id/episodes");
    // final response = await http.get(url);
    // if (response.statusCode == 200) {
    //   final episodes = jsonDecode(response.body);
    //   for (var episode in episodes) {
    //     episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
    //   }
    //   return episodesInstances;
    // }
    throw Error();
  }
}
