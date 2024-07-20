import 'dart:convert';
import 'package:http/http.dart' as http;

class LeaderboardService {
  static const String baseUrl =
      'http://192.168.1.6:5000'; // Replace with your API URL

  Future<List<LeaderboardEntryModel>> fetchOverallLeaderboard() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/auth/leaderboard/overall'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((entry) => LeaderboardEntryModel.fromJson(entry))
          .toList();
    } else {
      throw Exception('Failed to load overall leaderboard');
    }
  }

  Future<List<LeaderboardEntryModel>> fetchDailyLeaderboard() async {
    final response =
        await http.get(Uri.parse('$baseUrl/api/auth/leaderboard/daily'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data
          .map((entry) => LeaderboardEntryModel.fromJson(entry))
          .toList();
    } else {
      throw Exception('Failed to load daily leaderboard');
    }
  }
}

class LeaderboardEntryModel {
  final String rank;
  final String fullName;
  final String carbonSaved;

  LeaderboardEntryModel({
    required this.rank,
    required this.fullName,
    required this.carbonSaved,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryModel(
      rank: json['rank'] ?? 'N/A',
      fullName: json['fullName'],
      carbonSaved: json['totalCarbonFootPrintSaved']?.toString() ??
          json['dailyCarbonFootPrintSaved']?.toString() ??
          '0',
    );
  }
}
