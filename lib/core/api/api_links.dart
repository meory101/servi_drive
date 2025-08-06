class ApiGetUrl {

  static String tripRoutes = "trip-routes/active";
  static String conditions = "preferred-conditions/active";
  static String profile = "auth/profile";


}

class ApiPostUrl {
  static String register = "auth/register";
  static String createTrip = "trip-requests";
  static String login = "auth/login";
  static String verifyOtp = "auth/verify-otp";
  static String resendOtp = "auth/resend-otp";
  static String forgotPassword = "auth/forgot-password";
  static String resetPassword = "auth/reset-password";


}


class ApiDeleteUrl {

  static String deleteAccount = "functions/deleteAccount";


}
class ApiPutUrl {
  static String uploadProfileImage = "user/image";
  static String editProfile = "user/profile";

}
