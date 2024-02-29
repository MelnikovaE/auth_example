
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://d5dsstfjsletfcftjn3b.apigw.yandexcloud.net")
abstract class ApiServise{
  factory ApiServise(Dio dio, {String baseUrl}) = _ApiServise;

  @POST("/login")
  Future<void> sendVerificationCode(@Body() Map<String, dynamic> body);

  @POST("/confirm_code")
  Future<String> confirmCode(@Field("email") String email, @Field("code") int code);

  @POST("/refresh_token")
  Future<String> refreshToken(@Field("token") String rt,);

  @GET("/auth")
  Future<String> getUserId(@Header("Auth") String bearer_jwt);
}

