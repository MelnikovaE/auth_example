import 'package:auth_example/data/api/api_service.dart';
import 'package:dio/dio.dart';

class ApiRepository{
  final dios = Dio();
  final ApiServise _apiService = ApiServise(Dio());

  Future<void> sendVerificationCode(Map<String, dynamic> body) => _apiService.sendVerificationCode(body);

  Future<void> confirmCode(Map<String, dynamic> body) => _apiService.confirmCode(body);

  Future<void> refreshToken(Map<String, dynamic> body) => _apiService.refreshToken(body);

  Future<String> getUserId() => _apiService.getUserId();
}