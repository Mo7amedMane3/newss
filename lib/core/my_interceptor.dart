import 'package:dio/dio.dart';

import 'constants.dart';

class MyInterceptor implements Interceptor{
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({"x-api-key": AppConstants.APIKEY});
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);

  }
}