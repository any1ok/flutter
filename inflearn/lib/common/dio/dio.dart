import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:inflearn/common/const/data.dart';
import 'package:inflearn/common/secure_storage/secure_storage.dart';


final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureSotrageProvider);
  dio.interceptors.add(
      CustomInterceptor(storage: storage)
  );

  return dio;
});



class CustomInterceptor extends Interceptor{
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // TODO: implement onRequest
    print('[REQ] [${options.method}] ${options.uri}');

    if(options.headers['accessToken'] == 'true'){
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      options.headers.addAll({
        'authorization' : 'Bearer $token'
      });
    }

    if(options.headers['refreshToken'] == 'true'){
      options.headers.remove('refreshToken');
      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      options.headers.addAll({
        'authorization' : 'Bearer $token'
      });
    }

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // TODO: implement onError
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    if(refreshToken == null){
      return handler.reject(err);
    }

    final isStatus401 = err.response?.statusCode == 401;
    final isPathRefresh = err.requestOptions.path == '/auth/token';



    if(isStatus401 && !isPathRefresh){
      final dio = Dio();

      try{
        final resp = await dio.post(
            'http://$ip/auth/token',
            options: Options(
                headers: {
                  'authorization' : 'Bearer $refreshToken'
                }
            )
        );
        final accessToken = resp.data['accessToken'];
        final options = err.requestOptions;
        options.headers.addAll({
          'authorization' : 'Bearer $accessToken'
         }
        );
        
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);
        final response = await dio.fetch(options);
        return handler.resolve(response);
      }on DioError catch(e){
        return handler.reject(err);
      }

    }


    return super.onError(err, handler);
  }

}