import 'package:auth_example/data/api/api_service.dart';
import 'package:dio/dio.dart';

class ApiRepository {
  late final ApiServise _apiService;
  ApiRepository() {
    _apiService = ApiServise(Dio());
  }

  Future<void> sendVerificationCode(Map<String, dynamic> body) =>
      _apiService.sendVerificationCode(body);

  Future<String> confirmCode(String email, int code) =>
      _apiService.confirmCode(email, code);

  Future<String> refreshToken(String rt) =>
      _apiService.refreshToken(rt);

  Future<String> getUserId(String bearerJwt) =>
      _apiService.getUserId(bearerJwt);
}
