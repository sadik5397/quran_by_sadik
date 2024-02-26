class ApiConfig {
  // static String baseUrl = "https://hisocietyserver.online"; //LiveServer
  static String baseUrl = "https://dev.hisocietyserver.online"; //DemoServerer

  static Map<String, String> regularHeader() => {"Content-Type": "application/json", "charset": "utf-8"};

  static Map<String, String> authHeader(String accessToken) => {"Content-Type": "application/json", "Authorization": "Bearer $accessToken", "charset": "utf-8"};
}
