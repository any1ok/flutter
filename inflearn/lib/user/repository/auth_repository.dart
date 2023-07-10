import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inflearn/common/dio/dio.dart';
import 'package:inflearn/common/model/login_response.dart';
import 'package:inflearn/common/model/token_response.dart';
import 'package:inflearn/common/utils/data_utils.dart';

import '../../common/const/data.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(baseUrl: 'http://$ip/auth', dio: dio);
});

class AuthRepository{
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.baseUrl,
    required this.dio
});

  Future<LoginResponse> login({
    required String username,
    required String password,
}) async{
    final rawString = '$username:$password';
    final serialized = DataUtils.plainToBase64(rawString);
    final resp = await dio.post(
      '$baseUrl/login',
        options: Options(
            headers: {
              'authorization': 'Basic $serialized'
            }
        )
    );
    return LoginResponse.fromJson(resp.data);
  }
  Future<TokenResponse> token() async{
    final resp = await dio.post(
        '$baseUrl/token',
        options: Options(
            headers: {
              'refreshToken': 'true',
            }
        )
    );

    return TokenResponse.fromJson(resp.data);
  }

}