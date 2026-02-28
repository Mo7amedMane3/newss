import 'package:injectable/injectable.dart';
import 'package:newss/models/news_response.dart';
import 'package:newss/models/sources_response.dart';
abstract class HomeRemoteRepo {
  Future<SourcesResponse> getSources(String categoryId);

  Future<NewsResponse> getNews(String sourceId);
}