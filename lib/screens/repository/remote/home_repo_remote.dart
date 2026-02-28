import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:newss/models/news_response.dart';
import 'package:newss/models/sources_response.dart';
import 'package:newss/screens/repository/remote/home_repo.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../core/api_manger.dart';
import '../../../core/cache_helper.dart';
import '../../../core/constants.dart';
@Injectable(as: HomeRemoteRepo)
class HomeRepoRemoteImpl extends HomeRemoteRepo {
  ApiManager apiManager;

  HomeRepoRemoteImpl(this.apiManager);

  @override
  Future<NewsResponse> getNews(String sourceId) async {
    try {
      Response response = await apiManager.get(
        "/v2/everything",
        queryParameters: {"sources": sourceId},
      );

      NewsResponse newsResponse = NewsResponse.fromJson(response.data);

      await CacheHelper.saveNewsResponse(newsResponse, sourceId);
      return newsResponse;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }

  @override
  Future<SourcesResponse> getSources(String categoryId) async {
    try {
      Response response = await apiManager.get(
        "/v2/top-headlines/sources",
        queryParameters: {"category": categoryId},
      );

      SourcesResponse sourcesResponse = SourcesResponse.fromJson(response.data);

      await CacheHelper.saveSourceResponse(sourcesResponse,categoryId);
      return sourcesResponse;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}