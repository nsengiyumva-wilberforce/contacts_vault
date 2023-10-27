import 'package:dio/dio.dart';
import 'package:gic_call_center/Util/AppEndPoints.dart';
import 'package:retrofit/retrofit.dart';


part 'services.g.dart';

@RestApi(baseUrl: AppEndPoints.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(AppEndPoints.loginEndPoint)
  Future<dynamic> signIn({@Body() required Map<String, String> body});

  @POST(AppEndPoints.regiserEndPoint)
  Future<dynamic> signUp({@Body() required Map<String, String> body});

  @POST(AppEndPoints.logoutEndPoint)
  Future<dynamic> signOut();

  @POST(AppEndPoints.assignContacts)
  Future<dynamic> assignContacts({@Body() required Map<String, dynamic> body});

  @GET(AppEndPoints.contactsEndPoint)
  Future<dynamic> getContacts();

  @POST(AppEndPoints.verifyEmailEndPoint)
  Future<dynamic> verifyEmail({@Body() required Map<String, String> body});

  @POST(AppEndPoints.resendVerificationCodeEndPoint)
  Future<dynamic> resendVerificationCode({@Body() required Map<String, String> body});
}

