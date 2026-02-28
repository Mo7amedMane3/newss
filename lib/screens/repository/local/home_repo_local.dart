import 'package:injectable/injectable.dart';
import 'package:newss/models/news_response.dart';
import 'package:newss/models/sources_response.dart';

import '../../../core/cache_helper.dart';
import 'home_local_repo.dart';

@Injectable(as: HomeLocalRepo)
class HomeRepoLocalImpl extends HomeLocalRepo {
  @override
  Future<NewsResponse> getNews(String sourceId) async {
    var data = await CacheHelper.getNewsResponse(sourceId);
    return data ?? NewsResponse();
  }

  @override
  Future<SourcesResponse> getSources(String categoryId) async {
    var response = await CacheHelper.getSourceResponse(categoryId);
    return response ?? SourcesResponse();
  }
}