import 'package:dio/dio.dart';

import '../models/news_response.dart';
import '../models/sources_response.dart';
import 'constants.dart';

class ApiManger{
 static Dio dio=Dio();
 static Future<SourcesResponse> getSources()async{
    Response response=await dio.get(
        "${AppConstants.BASEURL}v2/top-headlines/sources?apiKey=${AppConstants.APIKEY}"
    );
        SourcesResponse sourcesResponse=SourcesResponse.fromJson(response.data);
        return sourcesResponse;


  }
 static Future<NewsResponse> getNewsData(String sourceId)async{
   Response response=await dio.get(
     "${AppConstants.BASEURL}/v2/everything?apiKey=${AppConstants.APIKEY}&sources=$sourceId"

   );
   NewsResponse newsResponse=NewsResponse.fromJson(response.data);
   return newsResponse;

  }

}