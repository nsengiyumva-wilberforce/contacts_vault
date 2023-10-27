class AppEndPoints
{
  static const String baseUrl = "https://impact-outsourcing.com/public/index.php/api/";
  static const String loginEndPoint = "/login";
  static const String regiserEndPoint = "/register";
  static const String logoutEndPoint = "/logout";
  static const String assignContacts = "/assign-contacts";
  static const String contactsEndPoint = "/contacts";
  static const String verifyEmailEndPoint = "/profile/verify-email";
  static const String resendVerificationCodeEndPoint = "/profile/resend-verification-code";
  static const int timeout = 30; 
  static String refreshToken = 'refresh_token';
  static String keyForJWTToken = 'accessToken';
}