part of JWTools;

class JWApi {
  static const _isDebug = true;
  static String imgBaseUrl = _isDebug ? "http://192.168.1.17:8080" : (JWManager().getUrl() ?? "");
  static String baseUrl = _isDebug ? "http://192.168.1.17:8080" : "http://jsonplaceholder.typicode.com";

  static const testApi = "/posts";
  static const testGuoLuApi = "/guolu";
  static const login = "/login";







}
