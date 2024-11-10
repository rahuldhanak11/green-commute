import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      "https://green-commute-9o3s.onrender.com"; // Replace with your API URL

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/login/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login user');
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(
      String userId, String otp) async {
    print(userId);
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/verify-otp/$userId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'otp': otp}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  static Future<Map<String, dynamic>> signUpUser(
      String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/auth/register/user'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'fullName': fullName, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up user');
    }
  }
}
