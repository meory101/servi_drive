

abstract class ApiStatusCode{
  static List<int> success()=> [200,201];
  static List<int> invalidSessionToken() => [209,119];
  static int serverError() => 500;
  static int badRequest() => 400;
}