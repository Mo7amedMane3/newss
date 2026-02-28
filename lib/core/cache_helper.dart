import 'package:hive/hive.dart';

import '../models/news_response.dart';
import '../models/sources_response.dart';

class CacheHelper {
  static const String _boxName = "SourcesBox1";
  static const String _newsBoxName = "NewsBox1";

  static Future<Box<NewsResponse>> _openNewsBox() async {
    if (!Hive.isBoxOpen(_newsBoxName)) {
      return await Hive.openBox<NewsResponse>(_newsBoxName);
    }

    return Hive.box<NewsResponse>(_newsBoxName);
  }

  static Future<void> saveNewsResponse(
      NewsResponse newsResponse,
      String sourceId,
      ) async {
    var box = await _openNewsBox();
    return box.put("newsResponse-$sourceId", newsResponse);
  }

  static Future<NewsResponse?> getNewsResponse(String sourceId) async {
    var box = await _openNewsBox();
    return box.get("newsResponse-$sourceId");
  }

  static Future<void> deleteNewsResponse() async {
    var box = await _openNewsBox();
    return box.delete("sources");
  }

  static Future<Box<SourcesResponse>> _openSourceBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<SourcesResponse>(_boxName);
    }

    return Hive.box<SourcesResponse>(_boxName);
  }

  static Future<void> saveSourceResponse(
      SourcesResponse sourcesResponse,
      String catId
      ) async {
    var box = await _openSourceBox();
    return box.put("sources-$catId", sourcesResponse);
  }

  static Future<SourcesResponse?> getSourceResponse( String catId) async {
    var box = await _openSourceBox();
    return box.get("sources-$catId");
  }

  static Future<void> deleteSourceResponse() async {
    var box = await _openSourceBox();
    return box.delete("sources");
  }
}
