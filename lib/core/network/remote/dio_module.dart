import 'package:dio/dio.dart';
import 'package:fitness_app/core/network/remote/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

@module
abstract class DioModule {


  @lazySingleton
  CacheOptions provideCacheOptions() {
    return CacheOptions(
      store: MemCacheStore(),
      policy: CachePolicy.forceCache, // default policy
      hitCacheOnErrorCodes: [401, 403],
      priority: CachePriority.normal,
      maxStale: const Duration(days: 7),
    );
  }
  
  @lazySingleton
  Dio provideDio(PrettyDioLogger logger, AuthInterceptor authInterceptor,CacheOptions cacheOptions) {
    final dio = Dio();

    

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 40),
      receiveTimeout: const Duration(seconds: 40),
      //baseUrl: ApiConstants.baseUrl,
    );

    dio.interceptors.addAll([
      DioCacheInterceptor(options: cacheOptions),
      authInterceptor,
      logger,
    ]);
    
    return dio;
  }

  @lazySingleton
  PrettyDioLogger providerInterceptor() {
    return PrettyDioLogger(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    );
  }

  @lazySingleton
  AuthInterceptor provideAuthInterceptor() => AuthInterceptor();
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString('token');
    print('this is token from dio_module : $token');

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    return handler.next(options);
  }
}
