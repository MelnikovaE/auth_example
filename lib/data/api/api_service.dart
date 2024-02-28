
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net")
abstract class ApiServise{
  factory ApiServise(Dio dio, {String baseUrl}) = _ApiServise;

  @POST("/login")
  Future<void> sendVerificationCode(@Body() Map<String, dynamic> body);

  @POST("/confirm_code")
  Future<void> confirmCode(@Body() Map<String, dynamic> body);

  @POST("/refresh_token")
  Future<void> refreshToken(@Body()Map<String, dynamic> body);

  @GET("/auth")
  Future<String> getUserId();
}