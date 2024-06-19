
class Utils {
  static Future<Map<String, dynamic>> getHeader(String? token) async {
    return <String, dynamic>{
      'Content-Type': 'application/json',
      'X-Pinggy-No-Screen': false,
      'Authorization': 'Bearer $token',
    };
  }

  static bool nullOrEmpty(String? token){
    return token == null || token == '';
  }
}
