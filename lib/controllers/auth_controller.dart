import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services.dart';

class AuthController {
  static String ACCESS_TOKEN = "access_token";

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      Map<String, String> user = {"email": email, "password": password};
      final response = await client.signIn(body: user);

      if (response.containsKey('authorization') &&
          response['authorization'].containsKey('token')) {
        final accessToken = response['authorization']['token'];
        await saveAccessToken(accessToken);
        print(response);
        return response;
      } else {
        return {
          "error": "Invalid credentials",
          "status": "error",
        };
      } // Handle the case when the access token is not present in the response
    } catch (e) {
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN, accessToken);
  }

  saveUserData(String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("userData", userData);
  }

  getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(ACCESS_TOKEN)) {
      return "";
    }
    return prefs.getString(ACCESS_TOKEN);
  }

  Future<Map<String, dynamic>> signUp(String email, String password,
      String first_name, String last_name) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      Map<String, String> user = {
        "email": email,
        "password": password,
        "first_name": first_name,
        "last_name": last_name
      };
      final response = await client.signUp(body: user);
      if (response.containsKey('user')) {
        // HTTP 200 OK indicates success
        return {
          "message": "User created successfully",
          "status": "success",
        };
      } else if (response.statusCode == 400) {
        // HTTP 400 Bad Request indicates client error (e.g., validation error)
        return {
          "error": "Invalid request",
          "status": "error",
        };
      } else if (response.statusCode == 401) {
        // HTTP 401 Unauthorized indicates authentication failure
        return {
          "error": "Unauthorized",
          "status": "error",
        };
      } else {
        // Handle other status codes (5xx server errors, etc.)
        return {
          "error": "Unexpected error occurred",
          "status": "error",
        };
      }
// Handle the case when the access token is not present in the response
    } catch (e) {
      print('error: $e');
      return {
        "error": "Invalid credentials",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> signOut() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.signOut();
      return response;
    } catch (e) {
      return {
        "error": "Failed to sign out",
        "status": "error",
      };
    }
  }

  Future<bool> verificationCodeIsValid(
      String email, num verificationCode) async {
    final dio = Dio();
    final client = RestClient(dio);

    try {
      final response = await client.verifyEmail(
          body: {"email": email, "code": verificationCode.toString()});

      print('response: $response');

      // Check for the response status code or any specific response data to determine validity
      if (response.containsKey('message')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> resendVerificationCode(String email) async {
    final dio = Dio();
    final client = RestClient(dio);
    try {
      final response =
          await client.resendVerificationCode(body: {"email": email});
      return response;
    } catch (e) {
      return {
        "error": "Failed to resend verification code",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> getContacts() async {
    final dio = Dio();
    final client = RestClient(dio);
    dio.options.headers['Authorization'] = "Bearer ${await getAccessToken()}";
    try {
      final response = await client.getContacts();
      return response;
    } catch (e) {
      return {
        "error": "Failed to get contacts",
        "status": "error",
      };
    }
  }

  Future<Map<String, dynamic>> assignContacts(String email) async {
    Dio dio = Dio();
    RestClient client = RestClient(dio);
    try {
      // Make the request to assign contacts
      final response = await client.assignContacts(body: {"email": email});

      if (response.containsKey('message')) {
        return {
          "message": "Contacts assigned successfully",
          "status": "success",
        };
      } else {
        return {
          "error": "Failed to assign contacts: ${response.statusCode}",
          "status": "error",
        };
      }
    } catch (e) {
      return {
        "error": "Failed to assign contacts",
        "status": "error",
      };
    } finally {
      dio.close();
    }
  }
}
