class LeagueResponseModel {
  final int success;
  final List<LeagueModel> result;

  LeagueResponseModel({
    required this.success,
    required this.result,
  });

  factory LeagueResponseModel.fromJson(Map<String, dynamic> json) {
    return LeagueResponseModel(
      success: json['success'],
      result: (json['result'] as List)
          .map((item) => LeagueModel.fromJson(item))
          .toList(),
    );
  }
}

class LeagueModel {
  final int? leagueKey;
  final String? leagueName;
  final int? countryKey;
  final String? countryName;
  final String? leagueLogo;
  final String? countryLogo;

  LeagueModel({
    required this.leagueKey,
    required this.leagueName,
    required this.countryKey,
    required this.countryName,
    required this.leagueLogo,
    required this.countryLogo,
  });

  factory LeagueModel.fromJson(Map<String, dynamic> json) {
    return LeagueModel(
      leagueKey: json['league_key'],
      leagueName: json['league_name'],
      countryKey: json['country_key'],
      countryName: json['country_name'],
      leagueLogo: json['league_logo'],
      countryLogo: json['country_logo'],
    );
  }
}
