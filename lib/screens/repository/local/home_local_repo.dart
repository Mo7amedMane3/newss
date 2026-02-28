import 'package:newss/models/news_response.dart';
import 'package:newss/models/sources_response.dart';

abstract class HomeLocalRepo {
  Future<SourcesResponse> getSources(String categoryId);

  Future<NewsResponse> getNews(String sourceId);
}