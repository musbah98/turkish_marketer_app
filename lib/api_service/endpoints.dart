class Endpoints {
  Endpoints._();

  static const String _baseUrl = "https://turkishexportpro.com/public/";
  static const String _api = "api/";
  static const String _version = "v1.0";
  static const String url = "$_baseUrl$_api$_version";

  static const String login = "$url/user/login";
  static const String signUp = "$url/user/signUp";
  static const String addCompany = "$url/user/addCompany";
  static const String verifyEmail = "$url/user/verifyEmail";
  static const String resendActivationCode = "$url/user/resendActivationCode";
  static const String logout = "$url/user/logout";
  static const String getOptions = "$url/constants/getOptions";
}
