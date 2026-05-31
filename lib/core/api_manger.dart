import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:newss/models/news_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'constants.dart';
import 'my_interceptor.dart' show MyInterceptor;

@lazySingleton
class ApiManager {
  late Dio dio;

  ApiManager() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.BASEURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          // "x-api-key": AppConstants.APIKEY,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    dio.interceptors.add(MyInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await dio.post(url, data: data, queryParameters: queryParameters);
  }

  static final Dio _dio = Dio();

  static Future<NewsResponse> searchArticles({
    required String searchQuery,
    required int pageNumber,
  }) async {
    try {
      final response = await _dio.get(
        "${AppConstants.BASEURL}${EndPoints.getArticles}",
        queryParameters: {
          "apiKey": AppConstants.APIKEY,
          "q": searchQuery,
          "page": pageNumber.toString(),
          "pageSize": 10,
        },
      );

      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
